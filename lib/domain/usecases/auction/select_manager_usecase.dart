import '../../../core/utils/result.dart';
import '../../entities/Auction.dart';

class SelectManagerUseCase {

  Result<void> call(String managerName, Auction auction) {
    if(auction.selectedManager != managerName){
      auction.selectedManager = managerName;
    }else{
      auction.selectedManager = '';
    }

    return Result.ok(null);
  }
}