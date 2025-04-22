
import 'package:asta_fantacalcio/core/routing/routes.dart';
import 'package:asta_fantacalcio/presentation/viewmodels/leagues/league_view_model.dart';
import 'package:asta_fantacalcio/presentation/pages/managers/managers_page.dart';
import 'package:asta_fantacalcio/presentation/viewmodels/managers/manager_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        final viewModel = LeagueViewModel(
          leaguesUseCase: context.read(),
          addLeagueUseCase: context.read(),
          removeLeagueUseCase: context.read(),
          clearLeagueUseCase: context.read(),
        );
        return LeaguesView(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/lega/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final viewModel = ManagerViewModel(
            managersUseCase: context.read(),
            addManagerUseCase: context.read(),
            removeManagerUseCase: context.read(),
            clearManagersUseCase: context.read(),
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
          auctionInitUseCase: context.read(),
          addPlayerUseCase: context.read(),
          removePlayerUseCase: context.read(),
          searchPlayerUseCase: context.read(), leagueName: name,
          selectManagerUseCase: context.read(), setBetUseCase: context.read(),
        );
        return AstaView(viewModel: viewModel);
      },
    ),
  ],
);