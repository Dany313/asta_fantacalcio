import 'package:asta_fantacalcio/domain/repositories/auction_repository.dart';

import '../../../core/utils/result.dart';
import '../../entities/Auction.dart';

class RemovePlayerUseCase {
  RemovePlayerUseCase({required AuctionRepository auctionRepository})
      : _auctionRepository = auctionRepository;

  final AuctionRepository _auctionRepository;

  Future<Result<void>> call(Auction auction) async {
    print("Rimuovendo giocatore: ${auction.selectedPlayer} al manager ${auction.selectedManager}");
    final result = await _auctionRepository.removePlayerFromManager(
        auction.league.nome,
        auction.selectedManager,
        auction.selectedPlayer);
    return result;
  }
}