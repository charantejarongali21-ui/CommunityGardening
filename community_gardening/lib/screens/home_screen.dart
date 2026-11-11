import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExplore;
  const HomeScreen({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('COMMUNITY GARDENING', style: TextStyle(fontSize: 11, letterSpacing: 1.4, color: Color(0xFF63806A), fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('Hello, ${state.user?.name ?? 'Gardener'}\nGrow together. Live greener.', style: TextStyle(fontSize: 24, height: 1.12, fontWeight: FontWeight.w800, color: Color(0xFF203B2B))),
                ],
              ),
            ),
            CircleAvatar(radius: 25, backgroundColor: Color(0xFFE5EEDC), child: Icon(Icons.local_florist, color: Color(0xFF285C3B), size: 28)),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [Color(0xFF285C3B), Color(0xFF56865A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('A greener neighbourhood starts with us.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Find a nearby garden, learn to grow plants and meet people in your community.', style: TextStyle(color: Colors.white70, height: 1.4)),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: onExplore,
                style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF285C3B)),
                child: const Text('Explore gardens'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Your community at a glance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StatCard(icon: Icons.park, number: '${state.filteredGardens.length}', label: 'Gardens')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.people_alt_outlined, number: '${state.joinedGardens.length}', label: 'Joined')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.event_available, number: '${state.registeredEvents.length}', label: 'Events')),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Gardening tip of the day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('??', style: TextStyle(fontSize: 30)),
                const SizedBox(width: 14),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Water wisely', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Water plants early in the morning to reduce evaporation and help roots absorb moisture.', style: TextStyle(color: Colors.black54, height: 1.4)),
                ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String label;
  const _StatCard({required this.icon, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Column(children: [
          Icon(icon, color: const Color(0xFF56865A)),
          const SizedBox(height: 7),
          Text(number, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ]),
      ),
    );
  }
}

