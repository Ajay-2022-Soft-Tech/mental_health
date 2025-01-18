import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';

class DashboardViewModel {
  final List<DashboardCardModel> cards = [
    DashboardCardModel(
      title: "Hydration Tracker",
      subtitle: "Track your daily water intake",
      icon: Icons.local_drink,
      route: '/hydration',
    ),
    DashboardCardModel(
      title: "Break Reminder",
      subtitle: "Take a break to stay productive",
      icon: Icons.timer,
      route: '/break',
    ),
    DashboardCardModel(
      title: "Mindfulness Exercises",
      subtitle: "Relax with guided meditation",
      icon: Icons.spa,
      route: '/mindfulness',
    ),
    DashboardCardModel(
      title: "Mood Tracking",
      subtitle: "Log and monitor your emotions",
      icon: Icons.sentiment_satisfied,
      route: '/mood',
    ),
  ];
}
