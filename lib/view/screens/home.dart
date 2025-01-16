import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/view/widgets/custom_container.dart';
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
      context.read<WallpaperBloc>().add(GetwallpaperEvent());
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
      context.read<WallpaperBloc>().add(GetwallpaperEvent());
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
            child: BlocBuilder<WallpaperBloc, WallpaperState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const LoadingWidget();
                }
                if (state is WallpapersLoadedState) {
                  return GridWidget(
                    wallpapers: state.wallpapers,
                    scrollController: scrollController,
                    state: state,
                  );
                }
                if (state is ErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
