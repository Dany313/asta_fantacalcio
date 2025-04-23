import 'package:dartz/dartz.dart';

import '../../core/utils/result.dart';
import '../entities/Player.dart';

abstract class AuctionRepository {
  Future<Either> addPlayerToManager(String leagueName, String managerName, String playerName, String playerRole, int price);
  Future<Either> removePlayerFromManager(String leagueName, String managerName, String playerName);


}