import 'package:asta_fantacalcio/feature/auction/domain/repositories/auction_repository.dart';

import '../../../../core/utils/result.dart';

class AddPlayerUseCase {
  AddPlayerUseCase({required AuctionRepository auctionRepository})
      : _auctionRepository = auctionRepository;

  final AuctionRepository _auctionRepository;

  Future<Result<void>> addLeague(String leagueName,String managerName,String playerName, int price) async {
    print("Aggiungendo giocatore: $playerName al manager $managerName con prezzo: $price");
    final result = await _auctionRepository.addPlayerToManager(leagueName, managerName, playerName, price);
    return result;
  }
}