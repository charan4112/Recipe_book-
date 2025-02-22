import 'favorites_screen.dart';

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
      body: Expanded(
        child: GridView.builder(
          itemCount: filteredRecipes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      recipe: filteredRecipes[index],
                      toggleFavorite: toggleFavorite,
                      isFavorite: favoriteRecipes.contains(filteredRecipes[index]),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: filteredRecipes[index]["name"]!,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          filteredRecipes[index]["image"]!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        filteredRecipes[index]["name"]!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
