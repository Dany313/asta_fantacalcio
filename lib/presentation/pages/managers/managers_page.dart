import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../../viewmodels/managers/manager_view_model.dart';
import '../../widgets/add_manager_dialog.dart';
import '../../widgets/allenatore_widget.dart';

const String addLegaButtonKey = 'add-lega-button';

class ManagersView extends StatefulWidget {
  const ManagersView({super.key, required this.viewModel, required this.leagueName});

  final ManagerViewModel viewModel;
  final String leagueName;

  @override
  State<ManagersView> createState() => _ManagersViewState();
}

class _ManagersViewState extends State<ManagersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Lega: ${widget.leagueName}"),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.astaWithName(widget.viewModel.leagueName));
              //widget.viewModel.clear.execute();

            },
            icon: Icon(Icons.add_chart),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key(addLegaButtonKey),
        child: const Icon(Icons.add),
        onPressed: () async {
          await showAddPartecipanteDialog(
            context,
            onAdd: (nome) {
              widget.viewModel.addManager.execute(nome);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Partecipante "$nome" aggiunto con successo')),
              );
            },
          );
        },
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: widget.viewModel.managers.length,
            itemBuilder: (context, index)  {
              final partecipante = widget.viewModel.managers[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.teamWithManager(widget.viewModel.leagueName,partecipante.nome));
                    },
                    child: AllenatoreWidget(
                        partecipante: partecipante,
                        deletePartecipante: widget.viewModel.removeManager, isAuction: false,
                                  ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

