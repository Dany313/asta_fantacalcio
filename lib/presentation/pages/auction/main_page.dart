import 'package:asta_fantacalcio/presentation/pages/auction/players_page.dart';
import 'package:asta_fantacalcio/presentation/pages/teams/teams_page.dart';
import 'package:asta_fantacalcio/presentation/viewmodels/teams/teams_view_model.dart';
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
  int _selectedIndex =
      1; // Inizializza con l'indice centrale (Asta) selezionato

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
            ),
          ),
          child: NavigationBar(
            backgroundColor: const Color(0xFF320099),
            indicatorColor: Colors.white.withOpacity(0.2),
            surfaceTintColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.people, color: Colors.white70),
                selectedIcon: Icon(Icons.people, color: Colors.white),
                label: 'Squadre',
              ),
              NavigationDestination(
                icon: Icon(Icons.gavel, color: Colors.white70),
                selectedIcon: Icon(Icons.gavel, color: Colors.white),
                label: 'Asta',
              ),
              NavigationDestination(
                icon: Icon(Icons.sports_soccer, color: Colors.white70),
                selectedIcon: Icon(Icons.sports_soccer, color: Colors.white),
                label: 'Giocatori',
              ),
            ],
          ),
        )
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return TeamsPage(
          viewModel: TeamsViewModel(
            leagueName: widget.viewModel.leagueName,
            managerName: '',
          ),
        );
      case 1:
        widget.viewModel.refreshLeague();
        return AuctionPage(viewModel: widget.viewModel);
      case 2:
        return PlayersPage(viewModel: widget.viewModel);
      default:
        return AuctionPage(viewModel: widget.viewModel);
    }
  }
}
