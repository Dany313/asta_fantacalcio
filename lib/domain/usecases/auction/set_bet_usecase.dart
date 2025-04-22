import '../../../core/utils/result.dart';
import '../../entities/Auction.dart';

class SetBetUseCase {

  Result<void> call(int bet, Auction auction) {
    if(bet > 0){
      auction.currentBet = bet;
    }
    return Result.ok(null);
  }
}