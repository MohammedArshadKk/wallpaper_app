import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            final height = index % 2 == 0 ? 250.0 : 200.0;
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 