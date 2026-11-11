import 'package:flutter/material.dart';
import 'package:community_gardening/screens/home_screen.dart';
import 'package:community_gardening/screens/gardens_screen.dart';
import 'package:community_gardening/screens/plants_screen.dart';
import 'package:community_gardening/screens/events_screen.dart';
import 'package:community_gardening/screens/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onExplore: () => setState(() => _selectedIndex = 1)),
      const GardensScreen(),
      const PlantsScreen(),
      const EventsScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _selectedIndex, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.park_outlined), selectedIcon: Icon(Icons.park), label: 'Gardens'),
          NavigationDestination(icon: Icon(Icons.eco_outlined), selectedIcon: Icon(Icons.eco), label: 'Plants'),
          NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
