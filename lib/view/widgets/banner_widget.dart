import 'package:flutter/material.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/view/widgets/custom_container.dart';
import 'package:wallpaper_app/view/widgets/custom_text.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key, required this.provider});
  final WallpaperProvider provider;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomContainer(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      provider.wallpapers[0].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 19,
                right: 19,
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
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                              CustomText(
                                text: 'Downloading...',
                                textAlign: TextAlign.center,
                                color: AppColors.primaryColor,
                              )
                            ],
                          );
                        },
                      );
                      provider
                          .downloadImage(provider.wallpapers[0].downloadLink);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
