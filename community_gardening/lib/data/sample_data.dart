import '../models/garden.dart';
import '../models/plant.dart';
import '../models/event.dart';

const gardens = <Garden>[
  Garden(id: 'g1', name: 'Sunrise Community Garden', location: 'Central Park', description: 'A friendly shared space for growing seasonal vegetables.', members: 24, emoji: '??'),
  Garden(id: 'g2', name: 'Green Corner Garden', location: 'Lake Road', description: 'A small neighbourhood garden with herbs and leafy greens.', members: 16, emoji: '??'),
  Garden(id: 'g3', name: 'Little Roots Garden', location: 'Community Centre', description: 'A welcoming garden for beginners and families.', members: 31, emoji: '??'),
];

const plants = <Plant>[
  Plant(id: 'p1', name: 'Tomato', category: 'Vegetable', season: 'Warm season', emoji: '??', tip: 'Give tomatoes plenty of sunlight and water near the soil.', water: 'Moderate, keep soil moist', sunlight: 'Full sun (6-8 hrs)'),
  Plant(id: 'p2', name: 'Spinach', category: 'Leafy green', season: 'Cool season', emoji: '??', tip: 'Keep the soil moist and harvest outer leaves first.', water: 'Regular, do not let dry', sunlight: 'Partial to full sun'),
  Plant(id: 'p3', name: 'Mint', category: 'Herb', season: 'Most seasons', emoji: '??', tip: 'Mint grows well in a pot and prefers moist soil.', water: 'Frequent, keep moist', sunlight: 'Partial shade'),
  Plant(id: 'p4', name: 'Carrot', category: 'Root vegetable', season: 'Cool season', emoji: '??', tip: 'Use loose soil so the roots can grow straight.', water: 'Moderate, deep watering', sunlight: 'Full sun'),
  Plant(id: 'p5', name: 'Sunflower', category: 'Flower', season: 'Warm season', emoji: '??', tip: 'Choose a sunny spot and support tall plants if needed.', water: 'Moderate', sunlight: 'Full sun'),
];

const gardenEvents = <GardenEvent>[
  GardenEvent(id: 'e1', title: 'Weekend Garden Clean-up', date: 'Saturday, 9:00 AM', place: 'Sunrise Community Garden', emoji: '??', description: 'Help clean and prepare beds for new planting.'),
  GardenEvent(id: 'e2', title: 'Seed Planting Workshop', date: 'Sunday, 10:30 AM', place: 'Community Centre', emoji: '??', description: 'Learn to sow seeds and care for seedlings.'),
  GardenEvent(id: 'e3', title: 'Compost Making Session', date: 'Next Wednesday, 4:00 PM', place: 'Green Corner Garden', emoji: '??', description: 'Turn kitchen waste into rich compost.'),
];
