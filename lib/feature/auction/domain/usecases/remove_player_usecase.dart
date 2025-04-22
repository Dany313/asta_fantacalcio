import 'package:asta_fantacalcio/feature/auction/domain/repositories/auction_repository.dart';

import '../../../../core/utils/result.dart';

class RemovePlayerUseCase {
  RemovePlayerUseCase({required AuctionRepository auctionRepository})
      : _auctionRepository = auctionRepository;

  final AuctionRepository _auctionRepository;

  Future<Result<void>> addLeague(String leagueName,String managerName,String playerName) async {
    print("Rimuovendo giocatore: $playerName al manager $managerName");
    final result = await _auctionRepository.removePlayerFromManager(leagueName, managerName, playerName);
    return result;
  }
}