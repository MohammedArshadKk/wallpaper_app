part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class GetwallpaperEvent extends WallpaperEvent {}

class DownloadWallpaperEvent extends WallpaperEvent {
  final String imageUrl;

  DownloadWallpaperEvent({required this.imageUrl});
}

class ResetWallpapersEvent extends WallpaperEvent {}
