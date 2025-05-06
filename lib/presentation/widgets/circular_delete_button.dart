import 'package:flutter/material.dart';

import '../../core/utils/command.dart';

class CircularDeleteButton extends StatelessWidget {
  final Command1<void, String>? delete;
  final String deleteParam;
  const CircularDeleteButton({super.key,required this.delete, required this.deleteParam});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        delete!.execute(deleteParam);
      },
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
