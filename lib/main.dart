import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/external/provider_logger.dart';
import 'movie_world.dart';

void main() {
      WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const AnimeWorld(),
    ),
  );
}
