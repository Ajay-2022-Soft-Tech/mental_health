import 'package:flutter/material.dart';

import '../viewmodels/dashboard_view_model.dart';
import '../widgets/dashboard_card.dart';

class HomeDashboard extends StatelessWidget {
  final viewModel = DashboardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self-Care Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.cards.length,
        itemBuilder: (context, index) {
          final card = viewModel.cards[index];
          return DashboardCard(
            title: card.title,
            subtitle: card.subtitle,
            icon: card.icon,
            onTap: () {
              Navigator.pushNamed(context, card.route);
            },
          );
        },
      ),
    );
  }
}
