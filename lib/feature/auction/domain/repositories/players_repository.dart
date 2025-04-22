import '../../../../core/utils/result.dart';
import '../entities/auction_entities.dart';

abstract class PlayersRepository {
  Future<Result<Map<String, Player>>> getGiocatori();
  Future<Result<Player>> getPlayer(String playerName);
}