import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Gardening events', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF203B2B))),
        const SizedBox(height: 6),
        const Text('Learn, share and grow with your neighbours.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 18),
        ...state.filteredEvents.map((event) {
          final registered = state.registeredEvents.contains(event.title);
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFEAF1E4), borderRadius: BorderRadius.circular(14)), child: Text(event.emoji, style: const TextStyle(fontSize: 25))),
                  const SizedBox(width: 12),
                  Expanded(child: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                ]),
                const SizedBox(height: 8),
                Text(event.description, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 13),
                Text('Date: ${event.date}'),
                const SizedBox(height: 6),
                Text('Place: ${event.place}', style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, child: registered
                  ? OutlinedButton(onPressed: () => state.toggleEvent(event.title), child: const Text('Registered - Cancel'))
                  : FilledButton(onPressed: () => state.toggleEvent(event.title), child: const Text('Register for event'))),
              ]),
            ),
          );
        }),
      ],
    );
  }
}
