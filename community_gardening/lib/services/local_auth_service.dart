import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user_profile.dart';
import 'auth_service.dart';

class LocalAuthService implements AuthService {
  static const _usersKey = 'cg_users';
  static const _currentKey = 'cg_current_uid';

  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  @override
  Future<AuthResult> signIn(String email, String password) async {
    final users = await _loadUsers();
    final match = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );
    if (match.isEmpty) {
      return AuthResult(success: false, message: 'Invalid email or password.');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentKey, match['uid'] as String);
    return AuthResult(success: true, user: UserProfile(uid: match['uid'], name: match['name'], email: match['email'], bio: match['bio'] ?? ''));
  }

  @override
  Future<AuthResult> signUp(String name, String email, String password) async {
    final users = await _loadUsers();
    if (users.any((u) => u['email'] == email)) {
      return AuthResult(success: false, message: 'Email already registered.');
    }
    final uid = const Uuid().v4();
    users.add({'uid': uid, 'name': name, 'email': email, 'password': password, 'bio': ''});
    await _saveUsers(users);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentKey, uid);
    return AuthResult(success: true, user: UserProfile(uid: uid, name: name, email: email));
  }

  @override
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentKey);
  }

  @override
  Future<AuthResult> resetPassword(String email) async {
    final users = await _loadUsers();
    final idx = users.indexWhere((u) => u['email'] == email);
    if (idx == -1) {
      return AuthResult(success: false, message: 'No account found for that email.');
    }
    users[idx]['password'] = 'reset123';
    await _saveUsers(users);
    return AuthResult(success: true, message: 'Password reset to "reset123" (demo).');
  }

  @override
  Future<UserProfile?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(_currentKey);
    if (uid == null) return null;
    final users = await _loadUsers();
    final match = users.firstWhere((u) => u['uid'] == uid, orElse: () => {});
    if (match.isEmpty) return null;
    return UserProfile(uid: match['uid'], name: match['name'], email: match['email'], bio: match['bio'] ?? '');
  }

  Future<void> updateProfile(UserProfile user) async {
    final users = await _loadUsers();
    final idx = users.indexWhere((u) => u['uid'] == user.uid);
    if (idx != -1) {
      users[idx]['name'] = user.name;
      users[idx]['bio'] = user.bio;
      await _saveUsers(users);
    }
  }
}
