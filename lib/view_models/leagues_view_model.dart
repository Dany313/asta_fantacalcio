
import 'package:asta_fantacalcio/repositories/players_repository.dart';
import 'package:flutter/cupertino.dart';


import '../../../repositories/leagues_repository.dart';
import '../model/league.dart';
import '../utils/command.dart';
import '../utils/result.dart';


class LeaguesViewModel extends ChangeNotifier {

  LeaguesViewModel({
    required LeaguesRepository leaguesRepository,
  }) : _leaguesRepository = leaguesRepository {
    load = Command0(_load)..execute();
  }

  late Command0 load;
  //final _log = Logger('LeaguesViewModel');
  final LeaguesRepository _leaguesRepository;
  List<League> _leagues = [];
  List<League> get leagues => _leagues;

  Future<Result> _load() async {
    try {
      final result = await _leaguesRepository.getLeagues();
      switch (result) {
        case Ok<List<League>>():
          _leagues = result.value;
          //_log.fine('Loaded bookings');
        case Error<List<League>>():
          //_log.warning('Failed to load bookings', result.error);
          return result;
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addLeague(League league) async {
    _leagues.add(league);
    await _leaguesRepository.saveLeagues(_leagues);
    notifyListeners();

  }

  Future<void> removeLeague(League league) async {
    _leagues.remove(league);
    await _leaguesRepository.saveLeagues(_leagues);
    notifyListeners();

  }
}