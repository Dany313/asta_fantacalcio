import 'player.dart';
import 'league.dart';
import 'manager.dart';

class AstaState {
  final bool isLoading;
  final League? league;
  final Map<String, Player> allAvailablePlayers;
  final Map<String, Player> filteredPlayers;
  final List<Manager> managers;
  final String selectedManager;
  final String selectedPlayer;
  final int currentBet;
  final String searchQuery;
  final String errorMessage;

  const AstaState({
    this.isLoading = false,
    this.league,
    this.allAvailablePlayers = const {},
    this.filteredPlayers = const {},
    this.managers = const [],
    this.selectedManager = '',
    this.selectedPlayer = '',
    this.currentBet = 0,
    this.searchQuery = '',
    this.errorMessage = '',
  });

  AstaState copyWith({
    bool? isLoading,
    League? league,
    Map<String, Player>? allAvailablePlayers,
    Map<String, Player>? filteredPlayers,
    List<Manager>? managers,
    String? selectedManager,
    String? selectedPlayer,
    int? currentBet,
    String? searchQuery,
    String? errorMessage,
  }) {
    return AstaState(
      isLoading: isLoading ?? this.isLoading,
      league: league ?? this.league,
      allAvailablePlayers: allAvailablePlayers ?? this.allAvailablePlayers,
      filteredPlayers: filteredPlayers ?? this.filteredPlayers,
      managers: managers ?? this.managers,
      selectedManager: selectedManager ?? this.selectedManager,
      selectedPlayer: selectedPlayer ?? this.selectedPlayer,
      currentBet: currentBet ?? this.currentBet,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}