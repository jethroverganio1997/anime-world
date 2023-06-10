import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:animenginamo/core/external/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../config/theme/theme_size.dart';

import '../anime_provider.dart';
import 'anime_featured_card.dart';
import 'anime_featured_shimmer.dart';

class AnimeFeatured extends HookConsumerWidget {
  const AnimeFeatured({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAnime = ref.watch(animeFeaturedProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.padding12),
      decoration: BoxDecoration(
        color: context.colorScheme.inversePrimary,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.decal,
          colors: [
            context.colorScheme.inversePrimary,
            context.colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight + Sizes.padding16),
          Expanded(
            child: featuredAnime.when(
              data: (anime) {
                return Animate(
                  effects: const [FadeEffect()],
                  child: AnimeFeaturedCard(
                    child: Image.network(
                      anime.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
              error: (e, s) {
                ref.read(dialogServiceProvider).error(e.toString());
                return const SizedBox.shrink();
              },
              loading: () => const AnimeFeaturedShimmer(),
            ),
          ),
          Sizes.verticalSpace24,
        ],
      ),
    );
  }
}
