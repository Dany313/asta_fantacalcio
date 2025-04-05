import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/giocatore.dart';
import '../model/lega.dart';
import '../model/partecipante.dart';
import '../utils/result.dart';


class LegheRepository {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/leghe.json');
  }

  Future<Result<List<Lega>>> load() async {

    final file = await _localFile;
    final contents = await file.readAsString();
    final List<dynamic> data = json.decode(contents);
    return Result.ok(data.map((json) => Lega.fromJson(json)).toList());

  }

  Future<List<Lega>> getLeghe() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      return data.map((json) => Lega.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Lega> getLega(String nomeLega) async {
    try {
      List<Lega> legheList =  await getLeghe();
      return legheList.firstWhere((e) => e.nome == nomeLega);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addLega(Lega lega) async {
    final file = await _localFile;
    final String response = await file.readAsString();
    final List<dynamic> data = json.decode(response);

    data.add(lega.toJson());
    await file.writeAsString(json.encode(data));
  }

  Future<void> removeLega(String nomeLega) async {
    try {
      List<Lega> legheList = await getLeghe();
      legheList.removeWhere((lega) => lega.nome == nomeLega);
      await saveLeghe(legheList);
    } catch (e) {
      return Future.error(e);
    }
  }


  Future<void> saveLeghe(List<Lega> leghe) async {
    final file = await _localFile;
    await file.writeAsString(json.encode(leghe.map((e) => e.toJson()).toList()));
  }

  Future<List<Partecipante>> getPartecipanti(String nomeLega) async {
    List<Lega> legheList =  await getLeghe();
    return legheList.firstWhere((e) => e.nome == nomeLega).partecipanti;

  }

  Future<void> addPartecipante(String nomeLega,Partecipante newPartecipante) async {
    List<Lega> legheList =  await getLeghe();
    legheList.firstWhere((e) => e.nome == nomeLega).partecipanti.add(newPartecipante);
    await saveLeghe(legheList);
  }

  Future<void> removePartecipante(String nomeLega,Partecipante partecipante) async {
    List<Lega> legheList =  await getLeghe();
    legheList.firstWhere((e) => e.nome == nomeLega).partecipanti.remove(partecipante);
    await saveLeghe(legheList);
  }

  Future<void> savePartecipanti(String nomeLega,List<Partecipante> partecipanti) async {
    List<Lega> legheList =  await getLeghe();
    legheList.firstWhere((e) => e.nome == nomeLega).partecipanti = partecipanti;
    await saveLeghe(legheList);
  }

  Future<void> updateLega(Lega lega) async {
    List<Lega> legheList =  await getLeghe();
    legheList.remove(lega);
    legheList.add(lega);
    await saveLeghe(legheList);
  }

  Future<void> addGiocatoreToPartecipante(String nomeGiocatore, int valoreAcq, String nomeLega, String nomePartecipante) async {
    try {
      List<Lega> legheList = await getLeghe();
      Lega lega = legheList.firstWhere((l) => l.nome == nomeLega);
      Partecipante partecipante = lega.partecipanti.firstWhere((p) => p.nome == nomePartecipante);

      // Aggiungi il giocatore alla mappa dei giocatori del partecipante
      partecipante.giocatori[nomeGiocatore] = valoreAcq;

      print(partecipante.giocatori);

      // Salva le modifiche
      await saveLeghe(legheList);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> removeGiocatoreFromPartecipante(String nomeGiocatore, String nomeLega, String nomePartecipante) async {
    try {
      List<Lega> legheList = await getLeghe();
      Lega lega = legheList.firstWhere((l) => l.nome == nomeLega);
      Partecipante partecipante = lega.partecipanti.firstWhere((p) => p.nome == nomePartecipante);

      // Aggiungi il giocatore alla mappa dei giocatori del partecipante
      partecipante.giocatori.remove(nomeGiocatore);

      // Salva le modifiche
      await saveLeghe(legheList);
    } catch (e) {
      return Future.error(e);
    }
  }
}