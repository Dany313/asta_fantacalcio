import 'package:asta_fantacalcio/routing/routes.dart';
import 'package:asta_fantacalcio/views/asta/asta_view.dart';
import 'package:asta_fantacalcio/views/home/home_view.dart';
import 'package:asta_fantacalcio/views/lega/lega_view.dart';
import 'package:go_router/go_router.dart';

import '../model/lega.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/lega/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        return LegaView(legaName: name);
      },
    ),
    GoRoute(
      path: '/asta',
      name: 'asta',
      builder: (context, state) {
        Lega sample = state.extra as Lega;
        return AstaView(lega: sample);
      },
    ),
  ],
);