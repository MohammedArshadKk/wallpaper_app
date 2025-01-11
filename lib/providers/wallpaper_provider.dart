import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

class WallpaperProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;
  List<WallpaperModel> wallpapers = [];
  bool hasMoreData = true;
  int currentIndex = 1;
  final Dio _dio = Dio();
  bool isdownloaded = false;
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
      log('Error loading wallpapers: $e');
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

  void downloadImage(String url, String fileName) async {
    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName.jpg';

    try {
      await dio.download(url, filePath);
      isdownloaded = true;
      log('Downloaded: $filePath');
      notifyListeners(); 
    } catch (e) {
      log('Error: $e');
    }
  }
}
