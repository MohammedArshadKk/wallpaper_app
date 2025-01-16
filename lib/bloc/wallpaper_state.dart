part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

final class WallpaperInitial extends WallpaperState {}

class LoadingState extends WallpaperState {}

class WallpapersLoadedState extends WallpaperState {
  final List<WallpaperModel> wallpapers;
  final bool hasMoreData;

  WallpapersLoadedState({required this.wallpapers, required this.hasMoreData});
}

class ErrorState extends WallpaperState {
  final String message;

  ErrorState({required this.message});
}
