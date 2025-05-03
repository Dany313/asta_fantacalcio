
import '../../domain/entities/player.dart';

class PlayerDTO {
  final int id;
  final String nome;
  final String squadra;
  final String ruolo;
  final int quotAttuale;

  PlayerDTO({
    required this.id,
    required this.nome,
    required this.squadra,
    required this.ruolo,
    required this.quotAttuale
  });

  factory PlayerDTO.fromJson(Map<String, dynamic> json) {
    return PlayerDTO(
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

  Player mapModelToEntity(){
    return Player(id: id, nome: nome, squadra: squadra, ruolo: ruolo, quotAttuale: quotAttuale);
  }

}