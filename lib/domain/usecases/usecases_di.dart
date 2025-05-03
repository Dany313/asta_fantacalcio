import 'package:asta_fantacalcio/domain/usecases/auction/add_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/auction_init_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_league_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/get_players_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/remove_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/search_player_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/leagues/add_league_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/leagues/clear_leagues_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/leagues/leagues_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/leagues/remove_league_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/managers/add_manager_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/managers/clear_managers_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/managers/managers_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/managers/remove_manager_usecase.dart';

import '../../service_locator.dart';

Future<void> initializeUseCasesDI() async {

  //LEAGUES
  serviceLocator.registerSingleton<AddLeagueUseCase>(
      AddLeagueUseCase()
  );

  serviceLocator.registerSingleton<ClearLeagueUseCase>(
      ClearLeagueUseCase()
  );

  serviceLocator.registerSingleton<LeaguesUseCase>(
      LeaguesUseCase()
  );

  serviceLocator.registerSingleton<RemoveLeagueUseCase>(
      RemoveLeagueUseCase()
  );

  //MANAGERS
  serviceLocator.registerSingleton<AddManagerUseCase>(
      AddManagerUseCase()
  );
  serviceLocator.registerSingleton<ClearManagersUseCase>(
      ClearManagersUseCase()
  );
  serviceLocator.registerSingleton<ManagersUseCase>(
      ManagersUseCase()
  );
  serviceLocator.registerSingleton<RemoveManagerUseCase>(
      RemoveManagerUseCase()
  );

  //AUCTION
  serviceLocator.registerSingleton<GetPlayersUseCase>(
      GetPlayersUseCase()
  );
  serviceLocator.registerSingleton<GetLeagueUseCase>(
      GetLeagueUseCase()
  );
  serviceLocator.registerSingleton<AddPlayerUseCase>(
      AddPlayerUseCase()
  );
  serviceLocator.registerSingleton<AuctionInitUseCase>(
      AuctionInitUseCase()
  );
  serviceLocator.registerSingleton<RemovePlayerUseCase>(
      RemovePlayerUseCase()
  );
  serviceLocator.registerSingleton<SearchPlayerUseCase>(
      SearchPlayerUseCase()
  );
}