import '../../model/giocatore.dart';
import '../../utils/result.dart';

abstract class GiocatoriRepository {

  Future<Result<Giocatore>> getGiocatore(String nome);
}