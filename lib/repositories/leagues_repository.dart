import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/league.dart';
import '../model/club.dart';
import '../utils/result.dart';


class LeaguesRepository {

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //
  //   return directory.path;
  // }
  //
  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   return File('$path/leagues.json');
  // }
  //
  // Future<Result<List<League>>> getLeagues() async {
  //   try {
  //     final file = await _localFile;
  //     final contents = await file.readAsString();
  //     final List<dynamic> jsonList = json.decode(contents);
  //     final leagues = jsonList.map((json) => League.fromJson(json)).toList();
  //     return Result.ok(leagues);
  //   } catch (e) {
  //     // Se 'e' non è già un'istanza di Exception, lo incapsula in una Exception.
  //     return Result.error(e is Exception ? e : Exception(e.toString()));
  //   }
  // }
  //
  // Future<Result<String>> _addLeague(League league) async {
  //   try{
  //     final file = await _localFile;
  //     final String response = await file.readAsString();
  //     final List<dynamic> data = json.decode(response);
  //
  //     data.add(league.toJson());
  //     await file.writeAsString(json.encode(data));
  //     return Result.ok("OK");
  //   }catch (e) {
  //     // Se 'e' non è già un'istanza di Exception, lo incapsula in una Exception.
  //     return Result.error(e is Exception ? e : Exception(e.toString()));
  //   }
  //
  // }

  // Future<Result<String>> _deleteLeague(String leagueName) async {
  //   try{
  //     final file = await _localFile;
  //     final String response = await file.readAsString();
  //     final List<dynamic> data = json.decode(response);
  //
  //     data.add(league.toJson());
  //     data.
  //     await file.writeAsString(json.encode(data));
  //     return Result.ok("OK");
  //   }catch (e) {
  //     // Se 'e' non è già un'istanza di Exception, lo incapsula in una Exception.
  //     return Result.error(e is Exception ? e : Exception(e.toString()));
  //   }
  //
  // }

  // Future<void> saveLeagues(List<League> leagues) async {
  //   final file = await _localFile;
  //   await file.writeAsString(json.encode(leagues.map((e) => e.toJson()).toList()));
  // }
  //
  // Future<Result<List<Club>>> getClubs(String leagueName) async {
  //   final leaguesResult = await getLeagues();
  //   if (leaguesResult is Ok<List<League>>) {
  //     try {
  //       final league = leaguesResult.value.firstWhere((e) => e.name == leagueName);
  //       return Result.ok(league.clubs);
  //     } catch (e) {
  //       return Result.error(Exception("League non trovata: $leagueName"));
  //     }
  //   } else if (leaguesResult is Error<List<League>>) {
  //     return Result.error(leaguesResult.error);
  //   }
  //   // Nel caso in cui non si entri in nessun caso precedente (in teoria non dovrebbe succedere)
  //   return Result.error(Exception("Errore sconosciuto"));
  // }


  // Future<void> addClub(String leagueName,Club newClub) async {
  //   List<League> leaguesList =  await getLeagues();
  //   leaguesList.firstWhere((e) => e.name == leagueName).clubs.add(newClub);
  //   await saveLeagues(leaguesList);
  // }
  //
  // Future<void> removeClub(String leagueName,Club club) async {
  //   List<League> leaguesList =  await getLeagues();
  //   leaguesList.firstWhere((e) => e.name == leagueName).clubs.remove(club);
  //   await saveLeagues(leaguesList);
  // }
  //
  // Future<void> saveClub(String leagueName,List<Club> clubs) async {
  //   List<League> leaguesList =  await getLeagues();
  //   leaguesList.firstWhere((e) => e.name == leagueName).clubs = clubs;
  //   await saveLeagues(leaguesList);
  // }
  //
  // Future<void> updateLeague(League league) async {
  //   List<League> leaguesList =  await getLeagues();
  //   leaguesList.remove(league);
  //   leaguesList.add(league);
  //   await saveLeagues(leaguesList);
  // }
}