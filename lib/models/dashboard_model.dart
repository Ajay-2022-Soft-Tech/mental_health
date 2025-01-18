import 'package:flutter/cupertino.dart';

class DashboardCardModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  DashboardCardModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}
