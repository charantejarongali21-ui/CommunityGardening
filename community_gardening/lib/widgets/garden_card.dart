import 'package:flutter/material.dart';
import '../models/garden.dart';

class GardenCard extends StatelessWidget {
  final Garden garden;
  final bool joined;
  final VoidCallback onToggle;
  const GardenCard({super.key, required this.garden, required this.joined, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58, height: 58,
              decoration: BoxDecoration(color: const Color(0xFFEAF1E4), borderRadius: BorderRadius.circular(16)),
              alignment: Alignment.center,
              child: Text(garden.emoji, style: const TextStyle(fontSize: 30)),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(garden.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(garden.location, style: const TextStyle(color: Color(0xFF63806A), fontSize: 12)),
                const SizedBox(height: 6),
                Text(garden.description, style: const TextStyle(color: Colors.black54, height: 1.3)),
                const SizedBox(height: 8),
                Text('${garden.members} community members', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: joined
                      ? OutlinedButton.icon(onPressed: onToggle, icon: const Icon(Icons.check, size: 17), label: const Text('Joined'))
                      : FilledButton.tonalIcon(onPressed: onToggle, icon: const Icon(Icons.add, size: 17), label: const Text('Join garden')),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
