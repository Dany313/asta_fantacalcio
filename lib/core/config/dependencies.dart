import 'package:asta_fantacalcio/feature/league/domain/usecases/clear_leagues_usecase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../feature/league/domain/repositories/leghe_repository.dart';
import '../../feature/league/domain/usecases/add_league_usecase.dart';
import '../../feature/league/domain/usecases/leagues_usecase.dart';
import '../../feature/league/domain/usecases/remove_league_usecase.dart';
import '../../feature/manager/domain/repositories/managers_repository.dart';
import '../../feature/manager/domain/usecases/add_manager_usecase.dart';
import '../../feature/manager/domain/usecases/clear_managers_usecase.dart';
import '../../feature/manager/domain/usecases/managers_usecase.dart';
import '../../feature/manager/domain/usecases/remove_manager_usecase.dart';
import '../repositories/json_repository.dart';


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
];

List<SingleChildWidget> get providersLocal {
  return [
    // Provider(
    //   create:
    //       (context) => GiocatoriJsonRepository() as GiocatoriRepository,
    // ),
    Provider(
      create:
          (context) => JsonRepository() as LegheRepository,
    ),
    Provider(
      create:
          (context) => JsonRepository() as ManagersRepository,
    ),
    ..._sharedProviders,
  ];
}