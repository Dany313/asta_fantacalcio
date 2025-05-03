import 'package:dartz/dartz.dart';

import '../../core/utils/result.dart';
import '../entities/league.dart';

abstract class LegheRepository {
  Future<Either> getLegheList();
  Future<Either> clearLegheList();
  Future<Either> getLega(String nome);
  Future<Either> addLega(String nomeLega, int maxBudget);
  Future<Either> removeLega(String nomeLega);
}