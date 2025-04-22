

import 'package:asta_fantacalcio/domain/entities/League.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/select_manager_usecase.dart';
import 'package:asta_fantacalcio/domain/usecases/auction/set_bet_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/command.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/Auction.dart';
import '../../../domain/entities/Player.dart';
import '../../../domain/usecases/auction/add_player_usecase.dart';
import '../../../domain/usecases/auction/auction_init_usecase.dart';
import '../../../domain/usecases/auction/remove_player_usecase.dart';
import '../../../domain/usecases/auction/search_player_usecase.dart';

class AstaViewModel extends ChangeNotifier {
  AstaViewModel({
    required AuctionInitUseCase auctionInitUseCase,
    required AddPlayerUseCase addPlayerUseCase,
    required RemovePlayerUseCase removePlayerUseCase,
    required SearchPlayerUseCase searchPlayerUseCase,
    required SelectManagerUseCase selectManagerUseCase,
    required SetBetUseCase setBetUseCase,
    required this.leagueName,
  }) : _auctionInitUseCase = auctionInitUseCase,
        _addPlayerUseCase = addPlayerUseCase,
        _searchPlayerUseCase = searchPlayerUseCase,
        _removePlayerUseCase = removePlayerUseCase,
  _selectManagerUseCase = selectManagerUseCase,
  _setBetUseCase = setBetUseCase{
    initAuction = Command0(_initAuction)..execute();
    addPlayer = Command0(_addPlayer);
    removePlayer = Command0(_removePlayer);
    searchPlayer = Command1(_searchPlayer);
    selectManager = Command1(_selectManager);
    setBet = Command1(_setBet);
  }

  late String leagueName;
  final SelectManagerUseCase _selectManagerUseCase;
  final AuctionInitUseCase _auctionInitUseCase;
  final AddPlayerUseCase _addPlayerUseCase;
  final RemovePlayerUseCase _removePlayerUseCase;
  final SearchPlayerUseCase _searchPlayerUseCase;
  final SetBetUseCase _setBetUseCase;

  late final Command0 initAuction;
  late Command0 addPlayer;
  late Command0 removePlayer;
  late Command1<void, String> searchPlayer;
  late Command1<void, String> selectManager;
  late Command1<void, int> setBet;
  late Auction _auction = Auction(
      league: League(nome: '', maxBudget: 500, partecipanti: []),
      players: {});

  Auction get auction => _auction;

  Future<Result<Auction>> _initAuction() async {
    try {
      print("Caricamento asta...");
      final result = await _auctionInitUseCase.call(leagueName);
      switch (result) {
        case Ok<Auction>():
          _auction = result.value;
          break;
        case Error<Auction>():
          return Result.error(result.error);
      }
      return Result.ok(result.value);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _setBet(int bet) async {
    try {
      print("imposto puntata $bet...");
      final result = _setBetUseCase(bet,auction);
      switch (result) {
        case Ok<void>():
          return Result.ok(result);
        case Error<void>():
          return Result.error(result.error);
      }
    }finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<List<String>>> _searchPlayer(String playerName)  async {
    try {
      print("Caricamento asta...");
      final result = await  _searchPlayerUseCase.call(playerName, auction.players);
      switch (result) {
        case Ok<List<String>>():
          return result;
        case Error<List<String>>():
          return result;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _selectManager(String managerName) async {
    try {
      final result = _selectManagerUseCase.call(managerName, auction);
      switch (result) {
        case Ok<void>():
          return Result.ok(result);
        case Error<void>():
          return Result.error(result.error);
      }
    }finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _removePlayer() async {
    try {
      final resultRemove = await _removePlayerUseCase.call(auction);
      switch (resultRemove) {
        case Ok<void>():
          print("Lega rimossa con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultRemove");
          return Result.error(resultRemove.error);;
      }

      print("Ricaricamento leghe dopo remove...");

      return _initAuction();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _addPlayer() async {
    try {
      final resultAdd = await _addPlayerUseCase(auction);
      switch (resultAdd) {
        case Ok<void>():
          print("Lega aggiunta con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultAdd");
          return Result.error(resultAdd.error);
      }

      print("Ricaricamento leghe dopo aggiunta...");
      return _initAuction();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}
