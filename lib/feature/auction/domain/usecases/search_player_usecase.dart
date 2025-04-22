import 'package:asta_fantacalcio/feature/auction/domain/repositories/players_repository.dart';

import '../../../../core/utils/result.dart';
import '../entities/auction_entities.dart';

class SearchPlayerUseCase {
  SearchPlayerUseCase({required PlayersRepository playersRepository})
      : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<Result<Player>> searchPlayer(String playerName) async {
    final result = await _playersRepository.getPlayer(playerName);
    return result;
  }
}