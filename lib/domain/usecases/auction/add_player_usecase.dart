import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';

import '../../../core/utils/result.dart';
import '../../entities/Auction.dart';

class AddPlayerUseCase {
  AddPlayerUseCase({required AuctionRepository auctionRepository})
      : _auctionRepository = auctionRepository;

  final AuctionRepository _auctionRepository;

  Future<Result<void>> call(Auction auction) async {
    print("Aggiungendo giocatore: ${auction.selectedPlayer} al manager ${auction.selectedManager} con prezzo: ${auction.currentBet}");
    final result = await _auctionRepository.addPlayerToManager(
        auction.league.nome,
        auction.selectedManager,
        auction.selectedPlayer,
        auction.currentBet
    );
    return result;
  }
}