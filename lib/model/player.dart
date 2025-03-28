class Player {
  final int id;
  final String name;
  final String team;
  final String role;
  final int actualQuote;

  Player({
    required this.id,
    required this.name,
    required this.team,
    required this.role,
    required this.actualQuote
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['Id'] as int,
      name: json['Nome'] as String,
      team: json['Squadra'] as String,
      role: json['R'] as String,
      actualQuote: json['Qt.A'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Nome': name,
      'Squadra': team,
      'R': role,
      'Qt.A': actualQuote,
    };
  }

}