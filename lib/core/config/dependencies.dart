import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:asta_fantacalcio/domain/usecases/teams/remove_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/search_player_usecase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/repositories/players_repository_impl.dart';
import '../../data/repositories/leagues_repository_impl.dart';
import '../../domain/repositories/leghe_repository.dart';
import '../../domain/repositories/managers_repository.dart';
import '../../domain/repositories/players_repository.dart';
import '../../domain/usecases/auction/add_player_usecase.dart';
import '../../domain/usecases/auction/auction_init_usecase.dart';
import '../../domain/usecases/leagues/add_league_usecase.dart';
import '../../domain/usecases/leagues/clear_leagues_usecase.dart';
import '../../domain/usecases/leagues/leagues_usecase.dart';
import '../../domain/usecases/leagues/remove_league_usecase.dart';
import '../../domain/usecases/managers/add_manager_usecase.dart';
import '../../domain/usecases/managers/clear_managers_usecase.dart';
import '../../domain/usecases/managers/managers_usecase.dart';
import '../../domain/usecases/managers/remove_manager_usecase.dart';

List<SingleChildWidget> _sharedProviders = [
  Provider(
    lazy: true,
    create: (context) => AddLeagueUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => ClearLeagueUseCase(),
),
  Provider(
    lazy: true,
    create: (context) => LeaguesUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => RemoveLeagueUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => AddManagerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => ClearManagersUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => ManagersUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => RemoveManagerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => AddPlayerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => AuctionInitUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => RemovePlayerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => SearchPlayerUseCase(),
  ),
];

List<SingleChildWidget> get providersLocal {
  return [
    Provider(
      create:
          (context) => PlayersRepositoryImpl() as PlayersRepository,
    ),
    Provider(
      create:
          (context) => LeaguesRepositoryImpl() as LegheRepository,
    ),
    Provider(
      create:
          (context) => LeaguesRepositoryImpl() as ManagersRepository,
    ),
    Provider(
      create:
          (context) => LeaguesRepositoryImpl() as AuctionRepository,
    ),
    ..._sharedProviders,
  ];
}