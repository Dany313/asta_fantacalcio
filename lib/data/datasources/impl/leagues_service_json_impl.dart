import 'dart:convert';
import 'dart:io';

import 'package:asta_fantacalcio/data/models/league_DTO.dart';
import 'package:asta_fantacalcio/data/models/manager_DTO.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';

import '../leagues_service.dart';

class LeaguesServiceJsonImpl implements LeaguesService {

  final List<LeagueDTO> _leaguesList;

  LeaguesServiceJsonImpl._(this._leaguesList);

  static Future<LeaguesServiceJsonImpl> create() async {

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/leghe.json');

      if (!await file.exists()) {
        await file.writeAsString(json.encode([]));
        return LeaguesServiceJsonImpl._([]);
      }

      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      return LeaguesServiceJsonImpl._(data.map((json) => LeagueDTO.fromJson(json)).toList());
  }


  void _updateLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/leghe.json');
    await file.writeAsString(json.encode(_leaguesList.map((e) => e.toJson()).toList()));
  }


  @override
  Future<Either> addLega(String leagueName, int maxBudget) async{
    try {
      _leaguesList.add(LeagueDTO(nome: leagueName, maxBudget: maxBudget, partecipanti: []));
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addManagerToLeague(String nomeLega, String nomePartecipante) async{
    try {
      _leaguesList.firstWhere((element) => element.nome == nomeLega)
          .partecipanti.add(ManagerDTO(
          nome: nomePartecipante,
          numP: 0,
          numD: 0,
          numC: 0,
          numA: 0,
          giocatori: {}));
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addPlayerToManager(String leagueName, String managerName, String playerName, String playerRole, int price) async {
    try {
      final league = _leaguesList.firstWhere(
              (league) => league.nome == leagueName,
          orElse: () => throw Exception("Lega '$leagueName' non trovata")
      );

      final manager = league.partecipanti.firstWhere(
              (manager) => manager.nome == managerName,
          orElse: () => throw Exception("Manager '$managerName' non trovato nella lega '$leagueName'")
      );

      if (manager.giocatori.containsKey(playerName)) {
        throw Exception("Il giocatore '$playerName' è già presente nella rosa di '$managerName'");
      }

      if (!['P', 'D', 'C', 'A'].contains(playerRole)) {
        throw Exception("Ruolo non valido. Deve essere uno tra: P, D, C, A");
      }

      switch (playerRole) {
        case 'P': manager.numP >= 3 ? throw Exception("Troppi P") : manager.numP += 1; break;
        case 'D': manager.numD >= 8 ? throw Exception("Troppi D") : manager.numD += 1; break;
        case 'C': manager.numC >= 8 ? throw Exception("Troppi C") : manager.numC += 1; break;
        case 'A': manager.numA >= 6 ? throw Exception("Troppi A") : manager.numA += 1; break;
      }

      manager.giocatori[playerName] = price;



      _updateLocalFile();
      return Right(null);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> clearLegheList() async {
    try {
      _leaguesList.clear();
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> clearManagersFromLeague(String nomeLega) async {
    try {
      _leaguesList.firstWhere((element) => element.nome == nomeLega)
          .partecipanti.clear();
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getLega(String nome) async {
    try {
      final league = _leaguesList.firstWhere(
            (element) => element.nome == nome,
        orElse: () => throw Exception("Lega non trovata"),
      );
      return Right(league.mapModelToEntity());
    } catch (e) {
      return Left(e);
    }

  }

  @override
  Future<Either> getLegheList() async {
    if(_leaguesList.isEmpty){
      return Right([]);
    } else {
      return Right(_leaguesList.map((element) => element.mapModelToEntity()).toList());
    }
  }

  @override
  Future<Either> getManagersFromLeague(String leagueName) async {
    try {
      final league = _leaguesList.firstWhere(
            (element) => element.nome == leagueName,
        orElse: () => throw Exception("Lega non trovata"),
      );
      return Right(league.partecipanti.map((element) => element.mapModelToEntity(league.maxBudget)).toList());
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> removeLega(String nomeLega) async {
    try {
      _leaguesList.removeWhere((element) => element.nome == nomeLega);
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> removeManagerFromLeague(String leagueName, String managerName) async{
    try {
      _leaguesList.firstWhere((element) => element.nome == leagueName)
          .partecipanti.removeWhere((element) => element.nome == managerName);
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> removePlayerFromManager(String leagueName, String managerName, String playerName) async {
    try {
      _leaguesList.firstWhere((element) => element.nome == leagueName)
          .partecipanti.firstWhere((element) => element.nome == managerName)
          .giocatori.remove(playerName);
      _updateLocalFile();
      return Right(null);
    }catch (e) {
      return Left(e);
    }
  }

}