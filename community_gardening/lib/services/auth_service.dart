import '../models/user_profile.dart';

class AuthResult {
  final bool success;
  final String? message;
  final UserProfile? user;
  AuthResult({required this.success, this.message, this.user});
}

abstract class AuthService {
  Future<AuthResult> signIn(String email, String password);
  Future<AuthResult> signUp(String name, String email, String password);
  Future<void> signOut();
  Future<AuthResult> resetPassword(String email);
  Future<UserProfile?> currentUser();
}
