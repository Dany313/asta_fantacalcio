
import 'package:asta_fantacalcio/core/routing/routes.dart';
import 'package:asta_fantacalcio/feature/league/presentation/view_models/league_view_model.dart';
import 'package:asta_fantacalcio/feature/manager/presentation/pages/managers_view.dart';
import 'package:asta_fantacalcio/feature/manager/presentation/view_models/manager_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../feature/league/presentation/pages/leagues_view.dart';


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
    // GoRoute(
    //   path: '/asta/:name',
    //   builder: (context, state) {
    //     final name = state.pathParameters['name']!;
    //     final viewModel = AstaViewModel(
    //       legheRepository: context.read(),
    //       giocatoriRepository: context.read(),
    //       nomeLega: name,
    //     );
    //     return AstaView(viewModel: viewModel);
    //   },
    // ),
  ],
);