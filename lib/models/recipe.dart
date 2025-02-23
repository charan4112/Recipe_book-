class Recipe {
  final String id;
  final String name;
  final String image;
  final List<String> ingredients;
  final String instructions;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}
