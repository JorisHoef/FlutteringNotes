import 'package:flutter/material.dart';

class NavigationConstants {
  static const String homeRoute = 'Home';
  static const String notesRoute = 'Notes';
  static const String tasksRoute = "Tasks";
  static const String optionsRoute = "Options";
}

const List<NavigationDestinationConfig> navigationDestinations = [
  NavigationDestinationConfig(
    icon: Icon(Icons.home),
    label: NavigationConstants.homeRoute,
    route: '/${NavigationConstants.homeRoute}',
  ),
  NavigationDestinationConfig(
    icon: Icon(Icons.note),
    label: NavigationConstants.notesRoute,
    route: '/${NavigationConstants.notesRoute}',
  ),
  NavigationDestinationConfig(
      icon: Icon(Icons.list_alt),
      label: NavigationConstants.tasksRoute,
      route: '/${NavigationConstants.tasksRoute}'
  ),
  NavigationDestinationConfig(
    icon: Icon(Icons.settings),
    label: NavigationConstants.optionsRoute,
    route: '/${NavigationConstants.optionsRoute}',
  ),
];

class NavigationDestinationConfig {
  final Icon icon;
  final String label;
  final String route;

  const NavigationDestinationConfig({
    required this.icon,
    required this.label,
    required this.route,
  });
}