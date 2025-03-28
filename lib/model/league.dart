import 'dart:math';

import 'club.dart';

class League {
  final String name;
  final int maxBudget;
  late final List<Club> clubs;

  League({
    required this.name,
    required this.maxBudget,
    required this.clubs
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! League) return false;
    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'] as String,
      maxBudget: json['max_budget'] as int,
      clubs: (json['clubs'] as List<dynamic>)
          .map((item) => Club.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'max_budget': maxBudget,
      'clubs': clubs.map((p) => p.toJson()).toList(),
    };
  }

}