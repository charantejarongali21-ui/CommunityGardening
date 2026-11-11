class Garden {
  final String id;
  final String name;
  final String location;
  final String description;
  final int members;
  final String emoji;
  const Garden({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.members,
    required this.emoji,
  });
  Garden copyWith({int? members}) => Garden(
        id: id,
        name: name,
        location: location,
        description: description,
        members: members ?? this.members,
        emoji: emoji,
      );
}
