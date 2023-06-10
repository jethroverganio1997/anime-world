// import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/router.dart';
import 'config/theme/dark_theme.dart';
import 'core/external/image_theme.dart';

class AnimeWorld extends ConsumerWidget {
  const AnimeWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final imageColorScheme = ref.watch(imageThemeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Anime World',
      themeMode: ThemeMode.dark,
      darkTheme: CustomTheme.darkTheme(context, imageColorScheme),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
    );
  }
}
