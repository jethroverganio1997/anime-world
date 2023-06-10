import 'dart:async';
import 'dart:math';

import 'package:animenginamo/config/theme/color_schemes.g.dart';
import 'package:animenginamo/core/extensions/ref_extension.dart';
import 'package:animenginamo/core/external/image_theme.dart';
import 'package:animenginamo/features/anime/data/anime_repository.dart';
import 'package:animenginamo/features/anime/domain/anime_model.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/error_exception.dart';
import '../domain/anime_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anime_provider.g.dart';

/// Provider to fetch a anime by ID
@riverpod
Future<AnimeInfoModel> animeInfo(
  AnimeInfoRef ref, {
  required String animeId,
}) {
  final cancelToken = ref.cancelToken();

  return ref.watch(animeRepoProvider).fetchAnimeInfo(
        id: animeId,
        cancelToken: cancelToken,
      );
}

@Riverpod(keepAlive: true)
Future<Anime> animeFeatured(AnimeFeaturedRef ref) async {
  final cancelToken = ref.cancelToken();

  final random = Random();
  final randomPage = random.nextInt(3);

  final data = await ref.read(animeRepoProvider).fetchTopAnime(
        page: randomPage,
        cancelToken: cancelToken,
      );

  final randomAnime = random.nextInt(10);
  final anime = data.anime[randomAnime];

  await ref.read(imageThemeProvider.notifier).colorSchemeFromImage(
        base: darkColorScheme,
        urlLink: anime.image,
      );

  return anime;
}

@riverpod
Future<AnimePageModel> fetchAnime(
  FetchAnimeRef ref, {
  required int page,
  String query = '',
}) async {
  final moviesRepo = ref.watch(animeRepoProvider);

  final cancelToken = CancelToken();
  // When a page is no-longer used, keep it in the cache.
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  if (query.isEmpty) {
    // use non-search endpoint
    return moviesRepo.fetchTopAnime(
      page: page,
      cancelToken: cancelToken,
    );
  } else {
    // Debounce the request. By having this delay, consumers can subscribe to
    // different parameters. In which case, this request will be aborted.
    await Future.delayed(const Duration(milliseconds: 300));
    if (cancelToken.isCancelled) throw AbortException();

    // use search endpoint
    return moviesRepo.searchAnime(
      page: page,
      query: query,
      cancelToken: cancelToken,
    );
  }
}
