import 'package:asta_fantacalcio/domain/entities/League.dart';

import 'Player.dart';

class Auction {
  final League league;
  final Map<String, Player> players;
  int currentBet = 0;
  String selectedManager = '';
  String selectedPlayer = '';

  Auction({
    required this.league,
    required this.players,
  });
}