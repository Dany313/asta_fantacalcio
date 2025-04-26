import 'package:flutter/material.dart';

class RoleCircle extends StatelessWidget {
  final String role;
  const RoleCircle(this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;

    switch(role){
      case 'P': color = Colors.orangeAccent; break;
      case 'D': color = Colors.green; break;
      case 'C': color = Colors.blue; break;
      case 'A': color = Colors.red; break;
    }
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Text(
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),role),
    );
  }
}
