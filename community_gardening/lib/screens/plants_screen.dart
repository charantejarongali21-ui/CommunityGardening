import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Plant guide', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF203B2B))),
        const SizedBox(height: 6),
        const Text('Simple growing information for your garden.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 16),
        TextField(
          onChanged: state.setPlantQuery,
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search plants', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.plantCategories.map((c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(c),
                selected: state.plantCategory == c,
                onSelected: (_) => state.setPlantCategory(c),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 12),
        ...state.filteredPlants.map((plant) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFFEAF1E4), child: Text(plant.emoji, style: const TextStyle(fontSize: 23))),
            title: Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${plant.category} - ${plant.season}'),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              Align(alignment: Alignment.centerLeft, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(plant.tip, style: const TextStyle(height: 1.4, color: Colors.black54)),
                const SizedBox(height: 6),
                Text('Water: ${plant.water}', style: const TextStyle(fontSize: 13)),
                Text('Sunlight: ${plant.sunlight}', style: const TextStyle(fontSize: 13)),
              ])),
            ],
          ),
        )),
        if (state.filteredPlants.isEmpty)
          const Padding(padding: EdgeInsets.only(top: 24), child: Center(child: Text('No plants found.'))),
      ],
    );
  }
}
