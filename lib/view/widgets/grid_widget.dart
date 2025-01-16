import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/view/widgets/banner_widget.dart';
import 'package:wallpaper_app/view/widgets/itom_widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.wallpapers,
    required this.scrollController, required this.state,
  });
  final List<WallpaperModel> wallpapers;
  final ScrollController scrollController;
  final WallpaperState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BannerWidget(wallpapers: wallpapers),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MasonryGridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: wallpapers.length,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    List<WallpaperModel> res = wallpapers.reversed.toList();
                    final WallpaperModel data = res[index];
                    return ItomWidget(
                      data: data,
                    );
                  },
                ),
              ),
              if (state is LoadingState)
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
          ),
        ),
      ],
    );
  }
}
