import 'package:flutter/material.dart';

class BetPanel extends StatelessWidget {
  const BetPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,   // direzione orizzontale sinistra→destra
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCA5AFF),  // stop 0%
            Color(0xFF642DD3),  // stop 100%
          ],
          // se vuoi personalizzare le stop positions (qui sono 0 e 1 di default):
          // stops: [0.0, 1.0],
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 25)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Puntata",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),),
                  Text("10",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 20
                    ),),
                ],
              ),
          VerticalDivider(
            color: Colors.white,
            thickness: 1,    // spessore di 1px
            width: 20,       // spazio orizzontale complessivo
            indent: 8,       // margine superiore
            endIndent: 8,    // margine inferiore
          ),
              TextButton(onPressed: (){},
              style: ButtonStyle(
                shape: WidgetStateProperty.all(CircleBorder()),
                // dimensione fissa del bottone
                fixedSize: WidgetStateProperty.all(Size(20, 20)),
                // oppure, se usi una versione di Flutter più vecchia:
                // minimumSize: MaterialStateProperty.all(Size(32, 32)),
                backgroundColor: WidgetStateProperty.all(Colors.greenAccent),
                foregroundColor: WidgetStateProperty.all(Color.fromRGBO(50, 0, 153, 1)),
                padding: WidgetStateProperty.all(EdgeInsets.zero), // rimuove padding interno
              ),
                  child: Text("+1"),),
              TextButton(onPressed: (){},
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(CircleBorder()),
                  // dimensione fissa del bottone
                  fixedSize: WidgetStateProperty.all(Size(20, 20)),
                  // oppure, se usi una versione di Flutter più vecchia:
                  // minimumSize: MaterialStateProperty.all(Size(32, 32)),
                  backgroundColor: WidgetStateProperty.all(Colors.greenAccent),
                  foregroundColor: WidgetStateProperty.all(Color.fromRGBO(50, 0, 153, 1)),
                  padding: WidgetStateProperty.all(EdgeInsets.zero), // rimuove padding interno
                ),
                child: Text("+5"),),
              TextButton(onPressed: (){},
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(CircleBorder()),
                  // dimensione fissa del bottone
                  fixedSize: WidgetStateProperty.all(Size(20, 20)),
                  // oppure, se usi una versione di Flutter più vecchia:
                  // minimumSize: MaterialStateProperty.all(Size(32, 32)),
                  backgroundColor: WidgetStateProperty.all(Colors.greenAccent),
                  foregroundColor: WidgetStateProperty.all(Color.fromRGBO(50, 0, 153, 1)),
                  padding: WidgetStateProperty.all(EdgeInsets.zero), // rimuove padding interno
                ),
                child: Text("+10"),),
            ],
        ),
      ),

    );
  }
}
