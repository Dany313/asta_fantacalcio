import 'package:dartz/dartz.dart';
import '../../../domain/repositories/players_repository.dart';
import '../../../service_locator.dart';

class GetManagerTeamUseCase {
  Future<Either> call(List<String> players) async {
    return await serviceLocator<PlayersRepository>().getPlayersFromList(
      players,
    );
  }
}
