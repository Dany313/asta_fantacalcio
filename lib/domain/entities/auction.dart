import 'package:asta_fantacalcio/domain/entities/league.dart';

import 'player.dart';

class Auction {
  late final League league;
  late final Map<String, Player> players;

  Auction({
    required this.league,
    required this.players,
  });
}