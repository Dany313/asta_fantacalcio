import 'package:asta_fantacalcio/data/repositories/leagues_repository_impl.dart';
import 'package:asta_fantacalcio/data/repositories/players_repository_impl.dart';
import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';
import 'package:asta_fantacalcio/domain/repositories/players_repository.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/impl/leagues_service_json_impl.dart';
import 'data/datasources/impl/players_service_json_impl.dart';
import 'data/datasources/leagues_service.dart';
import 'data/datasources/players_service.dart';
import 'domain/repositories/leghe_repository.dart';
import 'domain/repositories/managers_repository.dart';
import 'domain/usecases/usecases_di.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingletonAsync<PlayersService>(
        () => PlayersServiceJsonImpl.create(),
  );

  serviceLocator.registerSingletonAsync<LeaguesService>(
        () => LeaguesServiceJsonImpl.create(),
  );

  serviceLocator.registerSingleton<LegheRepository>(
    LeaguesRepositoryImpl()
  );

  serviceLocator.registerSingleton<ManagersRepository>(
      LeaguesRepositoryImpl()
  );

  serviceLocator.registerSingleton<AuctionRepository>(
      LeaguesRepositoryImpl()
  );

  serviceLocator.registerSingleton<PlayersRepository>(
      PlayersRepositoryImpl()
  );

  initializeUseCasesDI();
  
  await serviceLocator.allReady();
}