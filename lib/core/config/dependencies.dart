


import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/remove_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/search_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/select_manager_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/set_bet_usecase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/repositories/giocatori_json_repository.dart';
import '../../data/repositories/json_repository.dart';
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
    create: (context) => AddLeagueUseCase(legheRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => ClearLeagueUseCase(legheRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => LeaguesUseCase(legheRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => RemoveLeagueUseCase(legheRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => AddManagerUseCase(managersRepository: context.read(),
    ),
  ),
  Provider(
    lazy: true,
    create: (context) => ClearManagersUseCase(managersRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => ManagersUseCase(managersRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => RemoveManagerUseCase(managersRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => AddPlayerUseCase(auctionRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => AuctionInitUseCase(playersRepository: context.read(), legheRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => RemovePlayerUseCase(auctionRepository: context.read()),
  ),
  Provider(
    lazy: true,
    create: (context) => SearchPlayerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => SelectManagerUseCase(),
  ),
  Provider(
    lazy: true,
    create: (context) => SetBetUseCase(),
  ),
];

List<SingleChildWidget> get providersLocal {
  return [
    Provider(
      create:
          (context) => GiocatoriJsonRepository() as PlayersRepository,
    ),
    Provider(
      create:
          (context) => JsonRepository() as LegheRepository,
    ),
    Provider(
      create:
          (context) => JsonRepository() as ManagersRepository,
    ),
    Provider(
      create:
          (context) => JsonRepository() as AuctionRepository,
    ),
    ..._sharedProviders,
  ];
}