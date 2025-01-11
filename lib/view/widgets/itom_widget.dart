import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';

class ItomWidget extends StatelessWidget {
  const ItomWidget({super.key, required this.data, required this.provider});
final WallpaperModel  data;
final WallpaperProvider provider;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: data.imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              onPressed: () {
                provider.downloadImage(data.downloadLink,
                    DateTime.now().microsecondsSinceEpoch.toString());
                if (provider.isdownloaded) {
                  Get.snackbar(
                    'Success',
                    'Image Downloaded Successfully',
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.TOP,
                    duration: const Duration(seconds: 2),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(10),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
