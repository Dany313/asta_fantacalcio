import '../../../../core/utils/result.dart';

abstract class AuctionRepository {
  Future<Result<void>> addPlayerToManager(String leagueName, String managerName, String playerName, int price);
  Future<Result<void>> removePlayerFromManager(String leagueName, String managerName, String playerName);


}