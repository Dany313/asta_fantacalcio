import 'package:dartz/dartz.dart';

import '../../core/utils/result.dart';
import '../entities/player.dart';

abstract class AuctionRepository {
  Future<Either> addPlayerToManager(String leagueName, String managerName, String playerName, String playerRole, int price);
  Future<Either> removePlayerFromManager(String leagueName, String managerName, String playerName);


}