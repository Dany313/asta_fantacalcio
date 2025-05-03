import 'package:asta_fantacalcio/presentation/pages/auction/players_page.dart';
import 'package:asta_fantacalcio/presentation/pages/auction/teams_page.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/auction/asta_view_model.dart';
import 'auction_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.viewModel});

  final AstaViewModel viewModel;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Inizializza con l'indice centrale (Asta) selezionato

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Squadre',
          ),
          NavigationDestination(
            icon: Icon(Icons.gavel),
            label: 'Asta',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_soccer),
            label: 'Giocatori',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return TeamsPage(viewModel: widget.viewModel);
      case 1:
        return AuctionPage(viewModel: widget.viewModel);
      case 2:
        return PlayersPage(viewModel: widget.viewModel);
      default:
        return AuctionPage(viewModel: widget.viewModel);
    }
  }
}