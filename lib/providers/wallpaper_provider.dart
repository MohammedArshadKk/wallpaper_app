import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

class WallpaperProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;
  List<WallpaperModel> wallpapers = [];
  bool hasMoreData = true;
  int currentIndex = 1;
  bool isdownloading = false;
  Future<void> getWallpapers() async {
    if (isLoading || !hasMoreData) return;
    try {
      isLoading = true;
      notifyListeners();

      final List<WallpaperModel> newWallpapers =
          await apiService.getWallpapers(currentIndex);

      if (newWallpapers.isEmpty) {
        hasMoreData = false;
      } else {
        wallpapers.addAll(newWallpapers);
        currentIndex++;
      }
    } catch (e) {
      log('$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetWallpapers() {
    wallpapers.clear();
    currentIndex = 1;
    hasMoreData = true;
    notifyListeners();
  }

  Future<void> downloadImage(String url) async {
    try {
      isdownloading = true;
      notifyListeners();
      await apiService.downloadAndSaveImage(url);
      Get.back();
      Get.snackbar(
        'Success',
        'Image Downloaded Successfully',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
    } catch (e) {
      log(e.toString());
    } finally {
      isdownloading = false;
      notifyListeners();
    }
  }
}
