import '../../feature/auction/domain/entities/auction_entities.dart';

class Giocatore {
  final int id;
  final String nome;
  final String squadra;
  final String ruolo;
  final int quotAttuale;

  Giocatore({
    required this.id,
    required this.nome,
    required this.squadra,
    required this.ruolo,
    required this.quotAttuale
  });

  factory Giocatore.fromJson(Map<String, dynamic> json) {
    return Giocatore(
      id: json['Id'] as int,
      nome: json['Nome'] as String,
      squadra: json['Squadra'] as String,
      ruolo: json['R'] as String,
      quotAttuale: json['Qt.A'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Nome': nome,
      'Squadra': squadra,
      'R': ruolo,
      'Qt.A': quotAttuale,
    };
  }

  Player mapModeltoEntity(){
    return Player(id: id, nome: nome, squadra: squadra, ruolo: ruolo, quotAttuale: quotAttuale);
  }

}