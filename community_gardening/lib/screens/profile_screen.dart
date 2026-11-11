import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = state.user;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('My profile', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Color(0xFF203B2B))),
        const SizedBox(height: 22),
        Center(
          child: Column(children: [
            CircleAvatar(radius: 45, backgroundColor: const Color(0xFFE5EEDC), child: Text((user?.name ?? 'G').substring(0, 1).toUpperCase(), style: const TextStyle(fontSize: 32, color: Color(0xFF285C3B), fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            Text(user?.name ?? 'Garden Member', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(user?.email ?? '', style: const TextStyle(color: Colors.black54)),
            if ((user?.bio ?? '').isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text(user!.bio, style: const TextStyle(color: Colors.black54))),
          ]),
        ),
        const SizedBox(height: 18),
        FilledButton.tonal(onPressed: () => _editProfile(context, state), child: const Text('Edit profile')),
        const SizedBox(height: 24),
        const Text('My gardens', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (state.joinedGardens.isEmpty) const Text('You have not joined any gardens yet.', style: TextStyle(color: Colors.black54))
        else ...state.joinedGardens.map((g) => ListTile(leading: const Icon(Icons.park), title: Text(g))),
        const SizedBox(height: 16),
        const Text('Registered events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (state.registeredEvents.isEmpty) const Text('No events registered.', style: TextStyle(color: Colors.black54))
        else ...state.registeredEvents.map((e) => ListTile(leading: const Icon(Icons.event), title: Text(e))),
        const SizedBox(height: 24),
        OutlinedButton.icon(onPressed: () => state.signOut(), icon: const Icon(Icons.logout), label: const Text('Logout')),
        const SizedBox(height: 12),
        const Text('Community Gardening - Version 1.0.0', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontSize: 12)),
      ],
    );
  }

  Future<void> _editProfile(BuildContext context, AppState state) async {
    final user = state.user;
    if (user == null) return;
    final nameC = TextEditingController(text: user.name);
    final bioC = TextEditingController(text: user.bio);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: bioC, decoration: const InputDecoration(labelText: 'Bio', border: OutlineInputBorder())),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(onPressed: () {
            state.updateProfile(UserProfile(uid: user.uid, name: nameC.text.trim(), email: user.email, bio: bioC.text.trim()));
            Navigator.pop(ctx);
          }, child: const Text('Save')),
        ],
      ),
    );
  }
}
