import 'package:animenginamo/features/anime/presentation/anime_dashboard/anime_featured_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnimeFeaturedShimmer extends StatelessWidget {
  const AnimeFeaturedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
      child: const AnimeFeaturedCard(child: Placeholder()),
    );
  }
}
