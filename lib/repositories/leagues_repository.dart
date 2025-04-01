import 'dart:convert';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/league.dart';
import '../model/club.dart';
import '../utils/result.dart';


class LeaguesRepository {


  Future<Result<void>> addLeague(String leagueName, int maxBudget) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LeagueSchema],
      directory: dir.path,
    );
    await isar.leagues.put(League(name: leagueName, maxBudget: maxBudget));
    print("aggiunta");
    return Result.ok(null);
  }

  Future<Result<void>> removeLeague(String leagueName) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LeagueSchema],
      directory: dir.path,
    );
    await isar.leagues.filter().nameEqualTo(leagueName).deleteAll();
    return Result.ok(null);
  }

  Future<Result<void>> _renameLeague(String oldName, String newName) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LeagueSchema],
      directory: dir.path,
    );
    League? league = await isar.leagues.filter().nameEqualTo(oldName).findFirst();

    league?.name = newName;
    await isar.leagues.put(league!);


    return Result.ok(null);
  }

  Future<Result<void>> _modifyBudgetLeague(String leagueName, int newBudget) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LeagueSchema],
      directory: dir.path,
    );
    League? league = await isar.leagues.filter().nameEqualTo(leagueName).findFirst();

    league?.maxBudget = newBudget;
    await isar.leagues.put(league!);


    return Result.ok(null);
  }



}