import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../feature/auction/domain/repositories/auction_repository.dart';
import '../../feature/league/domain/entities/leagues_entities.dart';
import '../../feature/league/domain/repositories/leghe_repository.dart';
import '../../feature/manager/domain/repositories/managers_repository.dart';
import '../../feature/manager/domain/entities/managers_entities.dart';
import '../models/league_DTO.dart';
import '../models/manager_DTO.dart';
import '../utils/result.dart';



class JsonRepository implements LegheRepository, ManagersRepository, AuctionRepository {

  late var _leghe = List<LeagueDTO>.empty(growable: true);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/leghe.json');
  }

  @override
  Future<Result<List<League>>> getLegheList() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        await file.writeAsString(json.encode([]));
        return Result.ok(<League>[]);
      }
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      _leghe = data.map((json) => LeagueDTO.fromJson(json)).toList();
      return Result.ok(_leghe.map((toElement) => toElement.mapModeltoEntity()).toList());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> addLega(String nomeLega, int maxBudget) async {
    try {
      // Aggiungi la lega alla lista in memoria
      _leghe.add(LeagueDTO(nome: nomeLega, maxBudget: maxBudget, partecipanti: []));

      // Salva la lista nel file
      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> clearLegheList() async {
    try {
      // Aggiungi la lega alla lista in memoria
      _leghe.clear();

      final file = await _localFile;
      await file.writeAsString(json.encode([]));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> removeLega(String nomeLega) async {
    try {
      _leghe.removeWhere((lega) => lega.nome == nomeLega);

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> addManagerToLeague(String nomeLega, String nomePartecipante) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == nomeLega)
          .partecipanti
          .add(ManagerDTO(nome: nomePartecipante, giocatori: {}, numP: 0, numD: 0, numC: 0, numA: 0));

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<League>> getLega(String nome) async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      _leghe = data.map((json) => LeagueDTO.fromJson(json)).toList();
      return Result.ok(_leghe.firstWhere((lega) => lega.nome == nome).mapModeltoEntity());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> removeManagerFromLeague(String nomeLega, String nomePartecipante) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == nomeLega)
          .partecipanti.removeWhere((partecipanteTemp) => partecipanteTemp.nome == nomePartecipante);

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> clearManagersFromLeague(String nomeLega) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == nomeLega).partecipanti.clear();

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Manager>>> getManagersFromLeague(String leagueName) async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
    await file.writeAsString(json.encode([]));
    return Result.ok(<Manager>[]);
    }
    final contents = await file.readAsString();
    final List<dynamic> data = json.decode(contents);
    _leghe = data.map((json) => LeagueDTO.fromJson(json)).toList();
    return Result.ok(
        _leghe.firstWhere((legaTemp) => legaTemp.nome == leagueName)
            .partecipanti.map((toElement)=> toElement.mapModeltoEntity())

            .toList());
    } on Exception catch (e) {
    return Result.error(e);
    }
  }

  @override
  Future<Result<void>> addPlayerToManager(String leagueName, String managerName, String playerName, int price) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == leagueName)
          .partecipanti
          .firstWhere((tempManager) => tempManager.nome == managerName)
          .giocatori[playerName] = price;

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> removePlayerFromManager(String leagueName, String managerName, String playerName) async{
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == leagueName)
          .partecipanti
          .firstWhere((tempManager) => tempManager.nome == managerName)
          .giocatori.remove(playerName);

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }
}