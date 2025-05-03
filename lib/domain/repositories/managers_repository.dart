import 'package:dartz/dartz.dart';

import '../../core/utils/result.dart';
import '../entities/manager.dart';

abstract class ManagersRepository {
  Future<Either> addManagerToLeague(String nomeLega, String nomePartecipante);
  Future<Either> removeManagerFromLeague(String nomeLega, String nomePartecipante);
  Future<Either> clearManagersFromLeague(String nomeLega);
  Future<Either> getManagersFromLeague(String leagueName);
}