import 'package:animenginamo/core/external/http/api_service.dart';
import 'package:animenginamo/features/anime/domain/anime_info_model.dart';
import 'package:animenginamo/features/anime/domain/anime_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/external/http/http_service.dart';

final animeRepoProvider = Provider.autoDispose<AnimeRepository>((ref) {
  return AnimeRepository(ref.watch(apiServiceProvider));
});

abstract class AnimeRepository {
  factory AnimeRepository(HttpService api) = AnimeRepositoryImpl;
  Future<AnimeInfoModel> fetchAnimeInfo({required String id, CancelToken? cancelToken});
  Future<AnimePageModel> fetchTopAnime({required int page, CancelToken? cancelToken});
  Future<AnimePageModel> searchAnime({required String query, required int page, CancelToken? cancelToken});
  Future<AnimePageModel> fetchRecentEpisodes({required int page, CancelToken? cancelToken});
  Future<List<AnimeEpisodes>> fetchEpisodeStreamingLinks(
      {required String episodeId, String? server, CancelToken? cancelToken});
}

class AnimeRepositoryImpl implements AnimeRepository {
  final HttpService _api;
  AnimeRepositoryImpl(this._api);

  @override
  Future<AnimeInfoModel> fetchAnimeInfo({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final res = await _api.get('info/$id', cancelToken: cancelToken);
    return AnimeInfoModel.fromJson(res);
  }

  @override
  Future<AnimePageModel> fetchTopAnime({
    required int page,
    CancelToken? cancelToken,
  }) async {
    final res = await _api.get('top-airing', body: {'page': page}, cancelToken: cancelToken);
    return AnimePageModel.fromJson(res);
  }

  @override
  Future<AnimePageModel> searchAnime({
    required String query,
    required int page,
    CancelToken? cancelToken,
  }) async {
    final res = await _api.get(query, body: {'page': page}, cancelToken: cancelToken);
    return AnimePageModel.fromJson(res);
  }

  ///Note has an Type query params the default value is 1
  ///The [type] of anime to get, i.e. sub or dub. 1: Japanese
  ///Dub, English Sub; 2: English Dub, No Sub; 3: Chinese
  ///Dub, English Sub.
  @override
  Future<AnimePageModel> fetchRecentEpisodes({
    required int page,
    int? type = 1,
    CancelToken? cancelToken,
  }) async {
    final res = await _api.get(
      'recent-episodes',
      body: {'page': page, 'type': type},
      cancelToken: cancelToken,
    );
    return AnimePageModel.fromJson(res);
  }

  ///[servers] Enum: "gogocdn" "streamsb" "vidstreaming"
  @override
  Future<List<AnimeEpisodes>> fetchEpisodeStreamingLinks({
    required String episodeId,
    String? server = 'gogocdn',
    CancelToken? cancelToken,
  }) async {
    final res = await _api.get(
      'watch/$episodeId',
      body: {'server': server},
      cancelToken: cancelToken,
    );
    final data = res['sources'] as List;
    return data.map((e) => AnimeEpisodes.fromJson(e)).toList();
  }
}
