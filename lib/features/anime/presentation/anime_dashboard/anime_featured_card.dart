import 'package:animenginamo/core/extensions/buildcontext_extension.dart';
import 'package:animenginamo/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/theme_size.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

class AnimeFeaturedCard extends ConsumerWidget {
  const AnimeFeaturedCard({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.radius12)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bound) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.decal,
                stops: const [0.4, 0.99],
                colors: [
                  Colors.transparent,
                  context.colorScheme.surfaceTint.blend(context.colorScheme.surface, 14).withOpacity(0.84),
                ],
              ).createShader(bound);
            },
            blendMode: BlendMode.srcOver,
            child: child,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.padding16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play'),
                        ).expanded(),
                      ),
                      Sizes.horizontalSpace12,
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('My List'),
                        ).expanded(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
