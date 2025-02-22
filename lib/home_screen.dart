import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Map<String, String>> favoriteRecipes = [];
  List<Map<String, String>> recentlyViewed = [];
  List<Map<String, String>> filteredRecipes = allRecipes;
  List<String> shoppingList = []; // Shopping List
  String searchQuery = "";
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.forward();
  }

  void toggleFavorite(Map<String, String> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  void filterRecipes(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredRecipes = allRecipes.where((recipe) {
        return recipe["ingredients"]!.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  void navigateToDetails(Map<String, String> recipe) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return DetailsScreen(
            recipe: recipe,
            toggleFavorite: toggleFavorite,
            isFavorite: favoriteRecipes.contains(recipe),
            addToShoppingList: addToShoppingList,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Recipe Book', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: filterRecipes,
              decoration: InputDecoration(
                hintText: "Search by ingredients...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(child: Text("No recipes found!", style: TextStyle(fontSize: 18, color: Colors.grey)))
                : GridView.builder(
                    itemCount: filteredRecipes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => navigateToDetails(filteredRecipes[index]),
                        child: ScaleTransition(
                          scale: Tween(begin: 0.9, end: 1.0).animate(
                            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
                          ),
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
