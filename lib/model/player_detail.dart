class PlayerDetail {
  final int id;
  final String name;
  final String team;
  final String role;
  final int actualQuote;

  PlayerDetail({
    required this.id,
    required this.name,
    required this.team,
    required this.role,
    required this.actualQuote
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) {
    return PlayerDetail(
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