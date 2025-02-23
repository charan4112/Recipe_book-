class Recipe {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
