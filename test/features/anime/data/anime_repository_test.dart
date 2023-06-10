import 'package:animenginamo/features/anime/data/anime_repository.dart';
import 'package:animenginamo/features/anime/domain/anime_info_model.dart';
import 'package:animenginamo/features/anime/domain/anime_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  group(
    "Movie Repository Test -",
    () {
      test(
        "Get movie info",
        () async {
          //arrange
          final model = await container.read(animeRepoProvider).fetchAnimeInfo(id: 'spy-x-family');
          //act
          expect(model, isA<AnimeInfoModel>());
          //assert
        },
      );

      test(
        "Get top airing anime",
        () async {
          //arrange
          final model = await container.read(animeRepoProvider).fetchTopAnime(page: 3);
          //act
          expect(model, isA<AnimePageModel>());
          //assert
        },
      );

      test(
        "search anime",
        () async {
          //arrange
          final model = await container.read(animeRepoProvider).searchAnime(query: 'spy', page: 2);
          //act
          expect(model, isA<AnimePageModel>());
          //assert
        },
      );

      test(
        "get recent anime",
        () async {
          //arrange
          final model = await container.read(animeRepoProvider).fetchRecentEpisodes(page: 2);
          //act
          expect(model, isA<AnimePageModel>());
          //assert
        },
      );

      test(
        "get repisode stream link",
        () async {
          //arrange
          final model =
              await container.read(animeRepoProvider).fetchEpisodeStreamingLinks(episodeId: 'spy-x-family-episode-1');
          //act
          expect(model, isA<List<AnimeEpisodes>>());
          //assert
        },
      );
    },
  );
}
