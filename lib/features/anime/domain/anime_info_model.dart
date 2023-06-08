

import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_info_model.freezed.dart';
part 'anime_info_model.g.dart';

@freezed
class AnimeInfoModel with _$AnimeInfoModel {
  const factory AnimeInfoModel({
    required String id,
   required String title,
    required String url,
    required String image,
    String? releaseDate,
    String? description,
    required List<String> genres,
    required String subOrDub,
    String? type,
    required String status,
    String? otherName,
    required int totalEpisodes,
   required List<Episode> episodes,
  }) = _AnimeInfoModel;

  factory AnimeInfoModel.fromJson(Map<String, dynamic> json) => _$AnimeInfoModelFromJson(json);
}

@freezed
class Episode with _$Episode {
  const factory Episode({
    required String id,
    required int number,
    required String url,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
}
