import '../../core/utils/result.dart';
import '../entities/Player.dart';

abstract class PlayersRepository {
  Future<Result<Map<String, Player>>> getGiocatori();
  Future<Result<Player>> getPlayer(String playerName);
}