import 'package:animenginamo/config/theme/theme_size.dart';
import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:animenginamo/features/anime/domain/anime_model.dart';
import 'package:flutter/material.dart';

import 'anime_poster.dart';

class AnimeTile extends StatelessWidget {
  const AnimeTile({super.key, required this.anime, required this.onTap});

  final Anime anime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.padding16, vertical: Sizes.padding8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AnimePoster.width,
                height: AnimePoster.height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.padding4),
                ),
                child: AnimePoster(imagePath: anime.image),
              ),
              Sizes.horizontalSpace12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium,
                    ),
                    Text(
                      anime.genres?.map((e) => e).toList().join(' • ').toString() ?? "",
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
