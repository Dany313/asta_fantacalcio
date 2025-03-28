import 'player.dart';

class Club{
  final String managerName;
  final Map<String,int> players;

  Club({
    required this.managerName,
    required this.players
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Club) return false;
    return other.managerName == managerName;
  }

  @override
  int get hashCode => managerName.hashCode;

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      managerName: json['manager_name'] as String,
        players: (json['players'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, value as int),)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manager_name': managerName,
      'players': players
    };
  }
}