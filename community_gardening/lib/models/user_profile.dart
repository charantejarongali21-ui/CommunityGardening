class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String bio;
  UserProfile({required this.uid, required this.name, required this.email, this.bio = ''});
  UserProfile copyWith({String? name, String? bio}) =>
      UserProfile(uid: uid, name: name ?? this.name, email: email, bio: bio ?? this.bio);
}
