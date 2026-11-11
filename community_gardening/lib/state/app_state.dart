import 'package:flutter/material.dart';
import '../models/garden.dart';
import '../models/plant.dart';
import '../models/event.dart' as m;
import '../models/user_profile.dart';
import '../data/sample_data.dart';
import '../services/auth_service.dart';
import '../services/local_auth_service.dart';
import '../services/firebase_auth_service.dart';

const bool useFirebase = false;

class AppState extends ChangeNotifier {
  final AuthService auth = useFirebase ? FirebaseAuthService() : LocalAuthService();
  UserProfile? user;
  bool loading = true;

  final Set<String> joinedGardens = {};
  final Set<String> registeredEvents = {};

  String gardenQuery = '';
  String plantQuery = '';
  String plantCategory = 'All';

  AppState() {
    _init();
  }

  Future<void> _init() async {
    user = await auth.currentUser();
    loading = false;
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    final r = await auth.signIn(email, password);
    if (r.success) {
      user = r.user;
      notifyListeners();
      return null;
    }
    return r.message;
  }

  Future<String?> signUp(String name, String email, String password) async {
    final r = await auth.signUp(name, email, password);
    if (r.success) {
      user = r.user;
      notifyListeners();
      return null;
    }
    return r.message;
  }

  Future<void> signOut() async {
    await auth.signOut();
    user = null;
    joinedGardens.clear();
    registeredEvents.clear();
    notifyListeners();
  }

  Future<String?> resetPassword(String email) async {
    final r = await auth.resetPassword(email);
    return r.success ? null : r.message;
  }

  void toggleGarden(String name) {
    if (!joinedGardens.add(name)) joinedGardens.remove(name);
    notifyListeners();
  }

  void toggleEvent(String title) {
    if (!registeredEvents.add(title)) registeredEvents.remove(title);
    notifyListeners();
  }

  void setGardenQuery(String q) { gardenQuery = q; notifyListeners(); }
  void setPlantQuery(String q) { plantQuery = q; notifyListeners(); }
  void setPlantCategory(String c) { plantCategory = c; notifyListeners(); }

  Future<void> updateProfile(UserProfile updated) async {
    if (auth is LocalAuthService) {
      await (auth as LocalAuthService).updateProfile(updated);
    } else if (auth is FirebaseAuthService) {
      await (auth as FirebaseAuthService).updateProfile(updated);
    }
    user = updated;
    notifyListeners();
  }

  List<Garden> get filteredGardens {
    final q = gardenQuery.toLowerCase();
    return gardens.where((g) => g.name.toLowerCase().contains(q) || g.location.toLowerCase().contains(q)).toList();
  }

  List<String> get plantCategories => ['All', ...{for (final p in plants) p.category}];

  List<Plant> get filteredPlants {
    final q = plantQuery.toLowerCase();
    return plants.where((p) {
      final matchQ = q.isEmpty || p.name.toLowerCase().contains(q) || p.category.toLowerCase().contains(q);
      final matchC = plantCategory == 'All' || p.category == plantCategory;
      return matchQ && matchC;
    }).toList();
  }

  List<m.GardenEvent> get filteredEvents => gardenEvents;
}
