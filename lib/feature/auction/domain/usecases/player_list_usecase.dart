import '../../../../core/utils/result.dart';
import '../entities/auction_entities.dart';
import '../repositories/players_repository.dart';

class PlayersListUseCase {
  PlayersListUseCase({required PlayersRepository playersRepository})
      : _playersRepository = playersRepository;

  final PlayersRepository _playersRepository;

  Future<Result<Map<String, Player>>> playersList() async {
    final result = await _playersRepository.getGiocatori();
    return result;
  }
}