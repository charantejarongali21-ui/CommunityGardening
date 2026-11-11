import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<AuthResult> signIn(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final doc = await _db.collection('users').doc(cred.user!.uid).get();
      final data = doc.data() ?? {};
      return AuthResult(success: true, user: UserProfile(
        uid: cred.user!.uid,
        name: data['name'] ?? cred.user!.displayName ?? 'Gardener',
        email: cred.user!.email ?? email,
        bio: data['bio'] ?? '',
      ));
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: e.message ?? 'Sign in failed.');
    } catch (e) {
      return AuthResult(success: false, message: e.toString());
    }
  }

  @override
  Future<AuthResult> signUp(String name, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user!.updateDisplayName(name);
      await _db.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
        'bio': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return AuthResult(success: true, user: UserProfile(uid: cred.user!.uid, name: name, email: email));
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: e.message ?? 'Sign up failed.');
    } catch (e) {
      return AuthResult(success: false, message: e.toString());
    }
  }

  @override
  Future<void> signOut() async => _auth.signOut();

  @override
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult(success: true, message: 'Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, message: e.message ?? 'Reset failed.');
    }
  }

  @override
  Future<UserProfile?> currentUser() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    final doc = await _db.collection('users').doc(u.uid).get();
    final data = doc.data() ?? {};
    return UserProfile(uid: u.uid, name: data['name'] ?? u.displayName ?? 'Gardener', email: u.email ?? '', bio: data['bio'] ?? '');
  }

  Future<void> updateProfile(UserProfile user) async {
    await _db.collection('users').doc(user.uid).set({'name': user.name, 'bio': user.bio}, SetOptions(merge: true));
  }
}
