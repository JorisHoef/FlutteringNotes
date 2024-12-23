import 'package:flutter/material.dart';

const String homeRoute = 'Home';
const String notesRoute = 'Notes';
const String optionsRoute = "Options";

const List<NavigationDestinationConfig> navigationDestinations = [
  NavigationDestinationConfig(
    icon: Icon(Icons.home),
    label: homeRoute,
    route: '/${homeRoute}',
  ),
  NavigationDestinationConfig(
    icon: Icon(Icons.note),
    label: notesRoute,
    route: '/${notesRoute}',
  ),
  NavigationDestinationConfig(
    icon: Icon(Icons.settings),
    label: optionsRoute,
    route: '/${optionsRoute}',
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