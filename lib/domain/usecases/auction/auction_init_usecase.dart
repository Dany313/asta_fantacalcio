import 'package:asta_fantacalcio/domain/repositories/leghe_repository.dart';

import '../../../core/utils/result.dart';
import '../../entities/Auction.dart';
import '../../entities/League.dart';
import '../../entities/Player.dart';
import '../../repositories/players_repository.dart';

class AuctionInitUseCase {
  final PlayersRepository _playersRepository;
  final LegheRepository _legheRepository;
  AuctionInitUseCase({required PlayersRepository playersRepository,
  required LegheRepository legheRepository})
      : _playersRepository = playersRepository,
        _legheRepository = legheRepository;



  Future<Result<Auction>> call(String leagueName) async {
    try {
      final playersResult = await _playersRepository.getGiocatori();
      final leagueResult = await _legheRepository.getLega(leagueName);

      final Map<String, Player> players;
      final League league;

      switch (playersResult) {
        case Ok<Map<String, Player>>():
          players = playersResult.value;
          break;
        case Error<Map<String, Player>>():
          return Result.error(playersResult.error);
      }

      switch (leagueResult) {
        case Ok<League>():
          league = leagueResult.value;
          break;
        case Error<League>():
          return Result.error(leagueResult.error);
      }

      return Result.ok(Auction(league: league, players: players));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}