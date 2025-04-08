import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../model/giocatore.dart';
import '../../model/lega.dart';
import '../../model/partecipante.dart';
import '../../utils/result.dart';
import 'leghe_repository.dart';


class LegheJsonRepository implements LegheRepository{



  late var _leghe = List<Lega>.empty(growable: true);
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/leghe.json');
  }

  @override
  Future<Result<List<Lega>>> getLegheList() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        await file.writeAsString(json.encode([]));
        return Result.ok(<Lega>[]);
      }
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      _leghe = data.map((json) => Lega.fromJson(json)).toList();
      return Result.ok(_leghe);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> addLega(String nomeLega, int maxBudget) async {
    try {
      // Aggiungi la lega alla lista in memoria
      _leghe.add(Lega(nome: nomeLega, maxBudget: maxBudget, partecipanti: []));

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
  Future<Result<void>> addPartecipanteToLega(String nomeLega, String nomePartecipante) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == nomeLega)
          .partecipanti
          .add(Partecipante(nome: nomePartecipante, giocatori: {}, numP: 0, numD: 0, numC: 0, numA: 0));

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  @override
  Future<Result<Lega>> getLega(String nome) async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      _leghe = data.map((json) => Lega.fromJson(json)).toList();
      return Result.ok(_leghe.firstWhere((lega) => lega.nome == nome));
       } on Exception catch (e) {
       return Result.error(e);
      }
  }

  @override
  Future<Result<void>> removePartecipanteFromLega(String nomeLega, String nomePartecipante) async {
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
  Future<Result<void>> clearPartecipantiFromLega(String nomeLega) async {
    try {
      _leghe.firstWhere((legaTemp) => legaTemp.nome == nomeLega).partecipanti.clear();

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }


}