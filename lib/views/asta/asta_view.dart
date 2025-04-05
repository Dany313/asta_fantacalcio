// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
//
// import '../../model/lega.dart';
// import '../../model/giocatore.dart';
// import '../../model/partecipante.dart';
// import '../../routing/routes.dart';
// import '../../view_models/asta_view_model.dart';
// import '../../widget/allenatore_widget.dart';
//
// class AstaView extends StatelessWidget {
//   final Lega lega;
//   const AstaView({super.key, required this.lega});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<AstaViewModel>(
//         create: (_) => AstaViewModel(),
//         builder: (context, child) {
//           final viewModel = context.watch<AstaViewModel>();
//
//           return Scaffold(
//             appBar: AppBar(
//               actions: [
//                 TextButton(onPressed: () => {
//
//                 }, child: Text("SQUADRE"))
//               ],
//                 leading: TextButton(
//                     onPressed: () => {
//                       context.push(
//                         Routes.legaWithName(
//                           lega.nome,
//                         ),
//                       ),
//                     },
//                     child: Text("BACK")),
//             ),
//             body: Column(
//               children: [
//                 // Campo di ricerca
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       labelText: "Cerca giocatore",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onChanged: (value) {
//                       context.read<AstaViewModel>().cercaGiocatori(value);
//                     },
//                   ),
//                 ),
//
//                 // Lista di giocatori filtrati
//                 if (viewModel.isLoading)
//                   Center(child: CircularProgressIndicator())
//                 else if (viewModel.giocatoriFiltrati.isNotEmpty)
//                   Container(
//                     height: 200,
//                     child: ListView.builder(
//                       itemCount: viewModel.giocatoriFiltrati.length,
//                       itemBuilder: (context, index) {
//                         final giocatore = viewModel.giocatoriFiltrati[index];
//                         return ListTile(
//                           title: Text(giocatore.nome),
//                           subtitle: Text(giocatore.squadra ?? ""),
//                           trailing: Text(giocatore.ruolo ?? ""),
//                           onTap: () {
//                             context.read<AstaViewModel>().selezionaGiocatore(giocatore);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//
//                 // Giocatore e partecipante selezionati
//                 if (viewModel.giocatoreSelezionato != null && viewModel.partecipanteSelezionato != null)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Assegnazione:',
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             SizedBox(height: 8),
//                             Text('Giocatore: ${viewModel.giocatoreSelezionato!.nome}'),
//                             Text('Partecipante: ${viewModel.partecipanteSelezionato!.nome}'),
//                             Text('Valore: ${viewModel.valoreCorrente}'),
//                             // Pulsante per confermare l'assegnazione
//                             SizedBox(height: 16),
//                             ElevatedButton(
//                               onPressed: () {
//                                 context.read<AstaViewModel>().assegnaGiocatore(lega.nome);
//                               },
//                               child: Text('Assegna Giocatore'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 // Sezione con contatore e pulsanti
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: () => context.read<AstaViewModel>().decrementaValore(),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           '${viewModel.valoreCorrente}',
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () => context.read<AstaViewModel>().incrementaValore(),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Lista dei partecipanti selezionabili
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: lega.partecipanti.length,
//                     itemBuilder: (context, index) {
//                       final partecipante = lega.partecipanti[index];
//                       final isSelected = viewModel.partecipanteSelezionato == partecipante;
//
//                       return GestureDetector(
//                         onTap: () {
//                           context.read<AstaViewModel>().selezionaPartecipante(partecipante);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.blue.withOpacity(0.2) : null,
//                             border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
//                             borderRadius: isSelected ? BorderRadius.circular(8) : null,
//                           ),
//                           child: AllenatoreWidget(partecipante: partecipante),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   }
// }