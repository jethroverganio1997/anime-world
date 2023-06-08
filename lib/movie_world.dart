// import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/router.dart';
import 'config/theme/dark_theme.dart';

class AnimeWorld extends ConsumerWidget {
  const AnimeWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      title: 'FEE Mobile',
      themeMode: ThemeMode.dark,
      darkTheme: CustomDarkTheme.darkTheme(context),
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
