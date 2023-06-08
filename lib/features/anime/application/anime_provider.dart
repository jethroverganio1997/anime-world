import 'package:animenginamo/features/anime/data/anime_repository.dart';
import 'package:animenginamo/features/anime/domain/anime_model.dart';
import 'package:dio/dio.dart';

import '../domain/anime_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anime_provider.g.dart';

/// Provider to fetch a anime by ID
@riverpod
Future<AnimeInfoModel> animeInfo(
  AnimeInfoRef ref, {
  required String animeId,
}) {
  final cancelToken = CancelToken();
  ref.onDispose(() {
    cancelToken.cancel();
  });
  return ref.watch(animeRepoProvider).getAnimeInfo(
        id: animeId,
        cancelToken: cancelToken,
      );
}

@riverpod
Future<AnimePageModel> topAnime(
  TopAnimeRef ref, {
  required int page,
}) {
  final cancelToken = CancelToken();
  ref.onDispose(() {
    cancelToken.cancel();
  });
  return ref.watch(animeRepoProvider).getTopAiringAnime(
        page: page,
        cancelToken: cancelToken,
      );
}
