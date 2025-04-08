import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/lega.dart';
import '../../model/giocatore.dart';
import '../../model/partecipante.dart';
import '../../routing/routes.dart';
import '../../view_models/asta_view_model.dart';
import '../../widget/allenatore_widget.dart';

class AstaView extends StatefulWidget {
  const AstaView({super.key, required this.viewModel});

  final AstaViewModel viewModel;

  @override
  State<AstaView> createState() => _AstaViewState();
}

class _AstaViewState extends State<AstaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("ASTA"),
        actions: [
          FilledButton(onPressed: () {
            
          }, child: Row(
            spacing: 3,
            children: [
              Icon(Icons.flag),
              Text("Termina"),
            ],
          ))
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: widget.viewModel.partecipanti.length,
            itemBuilder: (context, index)  {
              final partecipante = widget.viewModel.partecipanti[index];
              return Card(
                  child: AllenatoreWidget(
                      partecipante: partecipante,)
              );
            },
          );
        },
      ),
    );
  }
}