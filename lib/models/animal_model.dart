// lib/models/animal_model.dart

/// Kelas [Animal] adalah model untuk merepresentasikan data seekor hewan.
class Animal {
  final String name;
  final String type;
  final double weight;
  final List<String> habitat;
  final int height;
  final List<String> activities;
  final String image;
  final String wikipedia;

  // Constructor untuk kelas Animal.
  Animal({
    required this.name,
    required this.type,
    required this.weight,
    required this.habitat,
    required this.height,
    required this.activities,
    required this.image,
    required this.wikipedia,
  });
}
