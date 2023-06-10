// To parse this JSON data, do
//
//     final animeModel = animeModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_model.freezed.dart';
part 'anime_model.g.dart';

@freezed
class AnimePageModel with _$AnimePageModel {
  const factory AnimePageModel({
    required String currentPage,
    required bool hasNextPage,
    @JsonKey(name: 'results') required List<Anime> anime,
  }) = _AnimePageModel;

  factory AnimePageModel.fromJson(Map<String, dynamic> json) => _$AnimePageModelFromJson(json);
}

@freezed
class Anime with _$Anime {
  const factory Anime({
    required String id,
    required String title,
    required String image,
    required String url,
    List<String>? genres,
    String? episodeId,
    int? episodeNumber,
  }) = _Anime;

  factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
}

@freezed
class AnimeEpisodes with _$AnimeEpisodes {
  const factory AnimeEpisodes({
    required String url,
    required String quality,
  }) = _AnimeEpisodes;

  factory AnimeEpisodes.fromJson(Map<String, dynamic> json) => _$AnimeEpisodesFromJson(json);
}
