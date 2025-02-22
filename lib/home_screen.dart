import 'favorites_screen.dart'; // Import FavoritesScreen

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> favoriteRecipes = [];

  void toggleFavorite(Map<String, String> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Recipe Book', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favoriteRecipes: favoriteRecipes),
                ),
              );
            },
          ),
        ],
      ),
      body: // Existing body content
    );
  }
}
