import 'package:flutter/material.dart';

class CircularDeleteButton extends StatelessWidget {
  const CircularDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () { },
      iconSize: 16, // dimensione dell’icona interna, a piacere
      style: ButtonStyle(
        // dimensione fissa del bottone
        fixedSize: WidgetStateProperty.all(Size(32, 32)),
        // oppure, se usi una versione di Flutter più vecchia:
        // minimumSize: MaterialStateProperty.all(Size(32, 32)),
        backgroundColor: WidgetStateProperty.all(Color(0xFF4200CC)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(EdgeInsets.zero), // rimuove padding interno
      ),
      icon: Icon(Icons.delete_outline_rounded),
    );
  }


}
