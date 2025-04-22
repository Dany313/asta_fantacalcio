import 'package:asta_fantacalcio/domain/repositories/players_repository.dart';

import '../../../core/utils/result.dart';
import '../../entities/Player.dart';

class SearchPlayerUseCase {

  Result<List<String>> call(String playerName, Map<String, Player> players) {

    return Result.ok(players.keys
        .where((player) => player.toUpperCase().contains(playerName.toUpperCase()))
        .toList()
    );
  }
}