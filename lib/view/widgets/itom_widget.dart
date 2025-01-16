import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/view/widgets/custom_text.dart';

class ItomWidget extends StatelessWidget {
  const ItomWidget({
    super.key,
    required this.data,
  });
  final WallpaperModel data;

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
                context
                    .read<WallpaperBloc>()
                    .add(DownloadWallpaperEvent(imageUrl: data.downloadLink));
              },
            ),
          ),
        ),
      ],
    );
  }
}
