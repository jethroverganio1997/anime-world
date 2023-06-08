import 'package:animenginamo/config/router/router_constant.dart';
import 'package:animenginamo/features/anime/presentation/anime_dashboard/anime_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();

  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router.routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier();

//   final Ref _ref;

  List<RouteBase> get routes => [
        GoRoute(
          name: AppRoute.dashboard,
          path: AppRoute.dashboard,
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
            key: state.pageKey,
            child: const AnimeDashboardScreen(),
          ),
        ),
      ];
}
