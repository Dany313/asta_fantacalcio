import 'package:asta_fantacalcio/domain/repositories/players_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';


class SearchPlayerUseCase {

  Future<Either> call(String playerName) async {
    return await serviceLocator<PlayersRepository>().searchPlayer(playerName);
  }
}