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
  Future<Result<void>> removeLega(Lega lega) async {
    try {
      _leghe.remove(lega);

      final file = await _localFile;
      await file.writeAsString(json.encode(_leghe.map((e) => e.toJson()).toList()));

      return const Result.ok(null);
    }  on Exception catch (e){
      return Result.error(e);
    }
  }

  // Future<Result<List<Lega>>> loadLeghe() async {
  //
  //   final file = await _localFile;
  //   final contents = await file.readAsString();
  //   final List<dynamic> data = json.decode(contents);
  //   return Result.ok(data.map((json) => Lega.fromJson(json)).toList());
  //
  // }
  //
  // Future<List<Lega>> getLeghe() async {
  //   try {
  //     final file = await _localFile;
  //     final contents = await file.readAsString();
  //     final List<dynamic> data = json.decode(contents);
  //     return data.map((json) => Lega.fromJson(json)).toList();
  //   } catch (e) {
  //     return [];
  //   }
  // }
  //
  // Future<Lega> getLega(String nomeLega) async {
  //   try {
  //     List<Lega> legheList =  await getLeghe();
  //     return legheList.firstWhere((e) => e.nome == nomeLega);
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
  //
  // Future<void> addLega(Lega lega) async {
  //   final file = await _localFile;
  //   final String response = await file.readAsString();
  //   final List<dynamic> data = json.decode(response);
  //
  //   data.add(lega.toJson());
  //   await file.writeAsString(json.encode(data));
  // }
  //
  // Future<void> removeLega(String nomeLega) async {
  //   try {
  //     List<Lega> legheList = await getLeghe();
  //     legheList.removeWhere((lega) => lega.nome == nomeLega);
  //     await saveLeghe(legheList);
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
  //
  //
  // Future<void> saveLeghe(List<Lega> leghe) async {
  //   final file = await _localFile;
  //   await file.writeAsString(json.encode(leghe.map((e) => e.toJson()).toList()));
  // }
  //
  // Future<List<Partecipante>> getPartecipanti(String nomeLega) async {
  //   List<Lega> legheList =  await getLeghe();
  //   return legheList.firstWhere((e) => e.nome == nomeLega).partecipanti;
  //
  // }
  //
  // Future<void> addPartecipante(String nomeLega,Partecipante newPartecipante) async {
  //   List<Lega> legheList =  await getLeghe();
  //   legheList.firstWhere((e) => e.nome == nomeLega).partecipanti.add(newPartecipante);
  //   await saveLeghe(legheList);
  // }
  //
  // Future<void> removePartecipante(String nomeLega,Partecipante partecipante) async {
  //   List<Lega> legheList =  await getLeghe();
  //   legheList.firstWhere((e) => e.nome == nomeLega).partecipanti.remove(partecipante);
  //   await saveLeghe(legheList);
  // }
  //
  // Future<void> savePartecipanti(String nomeLega,List<Partecipante> partecipanti) async {
  //   List<Lega> legheList =  await getLeghe();
  //   legheList.firstWhere((e) => e.nome == nomeLega).partecipanti = partecipanti;
  //   await saveLeghe(legheList);
  // }
  //
  // Future<void> updateLega(Lega lega) async {
  //   List<Lega> legheList =  await getLeghe();
  //   legheList.remove(lega);
  //   legheList.add(lega);
  //   await saveLeghe(legheList);
  // }
  //
  // Future<void> addGiocatoreToPartecipante(String nomeGiocatore, int valoreAcq, String nomeLega, String nomePartecipante) async {
  //   try {
  //     List<Lega> legheList = await getLeghe();
  //     Lega lega = legheList.firstWhere((l) => l.nome == nomeLega);
  //     Partecipante partecipante = lega.partecipanti.firstWhere((p) => p.nome == nomePartecipante);
  //
  //     // Aggiungi il giocatore alla mappa dei giocatori del partecipante
  //     partecipante.giocatori[nomeGiocatore] = valoreAcq;
  //
  //     print(partecipante.giocatori);
  //
  //     // Salva le modifiche
  //     await saveLeghe(legheList);
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
  //
  // Future<void> removeGiocatoreFromPartecipante(String nomeGiocatore, String nomeLega, String nomePartecipante) async {
  //   try {
  //     List<Lega> legheList = await getLeghe();
  //     Lega lega = legheList.firstWhere((l) => l.nome == nomeLega);
  //     Partecipante partecipante = lega.partecipanti.firstWhere((p) => p.nome == nomePartecipante);
  //
  //     // Aggiungi il giocatore alla mappa dei giocatori del partecipante
  //     partecipante.giocatori.remove(nomeGiocatore);
  //
  //     // Salva le modifiche
  //     await saveLeghe(legheList);
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}