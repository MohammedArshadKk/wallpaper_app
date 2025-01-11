import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/view/widgets/itom_widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.provider,
    required this.scrollController,
  });
  final WallpaperProvider provider;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MasonryGridView.builder(
            controller: scrollController,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: provider.wallpapers.length,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              final WallpaperModel data = provider.wallpapers[index];
              return ItomWidget(
                data: data,
                provider: provider,
              );
            },
          ),
        ),
        if (provider.isLoading)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
