import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/external/image_theme.dart';
import 'core/external/provider_logger.dart';
import 'movie_world.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(imageThemeProvider);
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const AnimeWorld(),
    ),
  );
}
