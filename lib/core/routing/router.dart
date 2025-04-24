
import 'package:asta_fantacalcio/core/routing/routes.dart';
import 'package:asta_fantacalcio/presentation/viewmodels/leagues/league_view_model.dart';
import 'package:asta_fantacalcio/presentation/pages/managers/managers_page.dart';
import 'package:asta_fantacalcio/presentation/viewmodels/managers/manager_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/auction/auction_page.dart';
import '../../presentation/pages/leagues/leagues_page.dart';
import '../../presentation/viewmodels/auction/asta_view_model.dart';


// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return LeaguesView(viewModel: LeagueViewModel());
      },
    ),
    GoRoute(
      path: '/lega/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final viewModel = ManagerViewModel(
            leagueName: name,
        );
        return ManagersView(viewModel: viewModel, leagueName: name,);
      },
    ),
    GoRoute(
      path: '/asta/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final viewModel = AstaViewModel(
            leagueName: name
        );
        return AstaView(viewModel: viewModel);
      },
    ),
  ],
);