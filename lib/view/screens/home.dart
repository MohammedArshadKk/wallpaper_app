import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/view/widgets/banner_widget.dart';
import 'package:wallpaper_app/view/widgets/custom_container.dart';
import 'package:wallpaper_app/view/widgets/custom_text.dart';
import 'package:wallpaper_app/view/widgets/grid_widget.dart';
import 'package:wallpaper_app/view/widgets/loading_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WallpaperProvider>(context, listen: false).getWallpapers();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      Provider.of<WallpaperProvider>(context, listen: false).getWallpapers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomContainer(
            height: 100,
            width: double.infinity,
            color: AppColors.secounderyColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          Expanded(
            child: Consumer<WallpaperProvider>(
              builder: (context, provider, child) {
                if (provider.wallpapers.isEmpty && provider.isLoading) {
                  return const LoadingWidget();
                }
                if (provider.wallpapers.isEmpty && !provider.isLoading) {
                  return const Center(
                    child: Text('No wallpapers found'),
                  );
                }
                return GridWidget(
                    provider: provider,
                    scrollController: scrollController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
