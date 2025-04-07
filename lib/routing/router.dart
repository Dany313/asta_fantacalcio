import 'package:asta_fantacalcio/routing/routes.dart';
import 'package:asta_fantacalcio/view_models/lega_view_model.dart';
import 'package:asta_fantacalcio/views/asta/asta_view.dart';
import 'package:asta_fantacalcio/views/home/home_view.dart';
import 'package:asta_fantacalcio/views/lega/lega_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/lega.dart';
import '../view_models/home_view_model.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel(
          legheRepository: context.read(),
        );
        return HomeView(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/lega/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final viewModel = LegaViewModel(
          legheRepository: context.read(),
          nomeLega: name,
        );
        return LegaView(viewModel: viewModel);
      },
    ),
    // GoRoute(
    //   path: '/asta',
    //   name: 'asta',
    //   builder: (context, state) {
    //     Lega sample = state.extra as Lega;
    //     return AstaView(lega: sample);
    //   },
    // ),
  ],
);