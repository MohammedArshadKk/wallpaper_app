import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperInitial()) {
    int currentIndex = 1;
    bool hasMoreData = true;
    final ApiService apiService = ApiService();
    List<WallpaperModel> wallpapers = [];
    on<GetwallpaperEvent>((event, emit) async {
      if (state is LoadingState || !hasMoreData) return;

      emit(LoadingState());
      try {
        final newWallpapers = await apiService.getWallpapers(currentIndex);

        if (newWallpapers.isEmpty) {
          hasMoreData = false;
        } else {
          wallpapers.addAll(newWallpapers);
          currentIndex++;
        }

        emit(WallpapersLoadedState(
            wallpapers: wallpapers, hasMoreData: hasMoreData));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
        log(e.toString());
      }
    });
    on<ResetWallpapersEvent>(
      (event, emit) {
        wallpapers.clear();
        currentIndex = 1;
        hasMoreData = true;
        emit(WallpapersLoadedState(
            wallpapers: wallpapers, hasMoreData: hasMoreData));
      },
    );
    on<DownloadWallpaperEvent>(
      (event, emit) async {
        try {
          await apiService.downloadAndSaveImage(event.imageUrl);
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
          emit(ErrorState(message: e.toString()));
          log(e.toString());
        }
      },
    );
  }
}
