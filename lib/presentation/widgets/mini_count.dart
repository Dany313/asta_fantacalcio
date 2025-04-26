import 'package:flutter/material.dart';

class MiniCount extends StatelessWidget {
  /// Il widget da mostrare in alto (es. icona, testo, immagine…)
  final Widget topWidget;

  /// La stringa da mostrare in basso
  final String bottomText;

  /// Colore di sfondo del badge
  final Color backgroundColor;

  /// Colore del testo in basso
  final TextStyle bottomTextStyle;

  const MiniCount({
    super.key,
    required this.topWidget,
    required this.bottomText,
    this.backgroundColor = const Color(0xFF30038F), // viola di default
    this.bottomTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    // Se il topWidget è un Text, gli applichiamo un DefaultTextStyle che
    // imposta il colore a bianco; altrimenti lo lasciamo inalterato.
    final Widget header = topWidget is Text
        ? DefaultTextStyle.merge(
      style: const TextStyle(color: Colors.white),
      child: topWidget,
    )
        : topWidget;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.elliptical(25, 25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            Text(
              bottomText,
              style: bottomTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
