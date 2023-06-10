import 'package:animenginamo/config/theme/theme_size.dart';
import 'package:animenginamo/core/common_widgets/custom_scroll.dart';
import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:animenginamo/core/external/dialog_service.dart';
import 'package:animenginamo/features/anime/presentation/anime_dashboard/anime_featured.dart';
import 'package:animenginamo/features/anime/presentation/anime_dashboard/anime_tile.dart';
import 'package:animenginamo/features/anime/presentation/anime_dashboard/anime_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../anime_provider.dart';

class AnimeDashboardScreen extends HookConsumerWidget {
  const AnimeDashboardScreen({super.key});

  static const pageSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: MyCustomScrollBehavior(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: context.heightPercent(.80),
            title: Text(
              'AnimeNgInaMo',
              style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.onPrimaryContainer),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_rounded,
                    color: context.colorScheme.onPrimaryContainer,
                  )),
              Sizes.horizontalSpace12,
            ],
            flexibleSpace: const FlexibleSpaceBar(background: AnimeFeatured()),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final page = index ~/ pageSize + 1;
                debugPrint('PAGE: $page');
                final indexInPage = index % pageSize;
                debugPrint('INDEX: $indexInPage');
                final animePage = ref.watch(fetchAnimeProvider(page: page));

                return animePage.when(
                  error: (err, stack) {
                    ref.watch(dialogServiceProvider).error(err.toString());
                    return const SizedBox.shrink();
                  },
                  loading: () => const AnimeTileShimmer(),
                  data: (animes) {
                    if (indexInPage >= animes.anime.length) {
                      return const AnimeTileShimmer();
                    }
                    final anime = animes.anime[indexInPage];
                    return AnimeTile(
                      anime: anime,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
