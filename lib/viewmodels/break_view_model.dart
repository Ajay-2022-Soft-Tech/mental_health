import '../models/break_model.dart';

class BreakViewModel {
  final List<BreakModel> breakSuggestions = [
    BreakModel(title: "Stretch", description: "Stretch for 2 minutes", duration: 2),
    BreakModel(title: "Walk", description: "Take a quick walk", duration: 5),
    BreakModel(title: "Breathing Exercise", description: "Relax and breathe", duration: 3),
  ];
}
