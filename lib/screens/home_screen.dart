import 'package:flutter/material.dart';
import 'package:fluttering_notes/screens/note_writing_screen.dart';
import 'package:fluttering_notes/screens/note_overview_screen.dart';

import '../constants/navigation_constants.dart';
import '../constants/strings_constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = NoteOverviewPage();
        break;
      case 1:
        page = NoteWritingPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine which navigation to show based on the screen width
        if (constraints.maxWidth >= 600) {
          // Show NavigationRail for larger screens (e.g., tablets or desktop)
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 700,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text(homeRoute),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.note),
                        label: Text(notesRoute),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Show BottomNavigationBar for smaller screens (mobile devices)
          return Scaffold(
            body: page,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: homeRoute,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: notesRoute,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}