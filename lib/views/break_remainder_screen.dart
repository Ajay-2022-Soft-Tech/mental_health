import 'package:flutter/material.dart';

import '../viewmodels/break_view_model.dart';

class BreakReminderScreen extends StatelessWidget {
  final viewModel = BreakViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Break Reminder'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: viewModel.breakSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = viewModel.breakSuggestions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(suggestion.title),
              subtitle: Text(suggestion.description),
              trailing: Text('${suggestion.duration} min'),
              onTap: () {
                // Start Break Activity
              },
            ),
          );
        },
      ),
    );
  }
}
