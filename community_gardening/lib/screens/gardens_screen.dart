import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/garden_card.dart';
import '../state/app_state.dart';

class GardensScreen extends StatelessWidget {
  const GardensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Community gardens', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF203B2B))),
        const SizedBox(height: 6),
        const Text('Discover shared green spaces and become a member.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 16),
        TextField(
          onChanged: state.setGardenQuery,
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search gardens', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        ...state.filteredGardens.map((garden) => GardenCard(
          garden: garden,
          joined: state.joinedGardens.contains(garden.name),
          onToggle: () => state.toggleGarden(garden.name),
        )),
        if (state.filteredGardens.isEmpty)
          const Padding(padding: EdgeInsets.only(top: 24), child: Center(child: Text('No gardens found.'))),
      ],
    );
  }
}
