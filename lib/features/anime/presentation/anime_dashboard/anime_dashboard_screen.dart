import 'package:animenginamo/features/anime/application/anime_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimeDashboardScreen extends HookConsumerWidget {
  const AnimeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(topAnimeProvider(page: 1));

    return Container();
  }
}
