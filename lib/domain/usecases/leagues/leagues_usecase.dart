import 'package:asta_fantacalcio/domain/repositories/leghe_repository.dart';

import '../../../core/utils/result.dart';
import '../../entities/League.dart';

class LeaguesUseCase {
  LeaguesUseCase({required LegheRepository legheRepository})
    : _legheRepository = legheRepository;

  final LegheRepository _legheRepository;

  Future<Result<List<League>>> getLeagues() async {
    print("Caricamento partecipanti...");
    final result = await _legheRepository.getLegheList();
    return result;
  }
}
