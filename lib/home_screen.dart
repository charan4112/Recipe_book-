import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> favoriteRecipes = [];
  List<Map<String, String>> recentlyViewed = [];
  List<Map<String, String>> filteredRecipes = allRecipes;
  List<String> shoppingList = []; // 🛒 Shopping List Storage
  String searchQuery = "";

  void toggleFavorite(Map<String, String> recipe) {
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
  }

  void addToRecentlyViewed(Map<String, String> recipe) {
    setState(() {
      if (recentlyViewed.contains(recipe)) {
        recentlyViewed.remove(recipe);
      }
      recentlyViewed.insert(0, recipe);
      if (recentlyViewed.length > 5) {
        recentlyViewed.removeLast();
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

  void addToShoppingList(List<String> ingredients) {
    setState(() {
      for (var ingredient in ingredients) {
        if (!shoppingList.contains(ingredient)) {
          shoppingList.add(ingredient);
        }
      }
    });
  }

  void removeFromShoppingList(String ingredient) {
    setState(() {
      shoppingList.remove(ingredient);
    });
  }

  void showShoppingList() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 350,
          child: Column(
            children: [
              const Text(
                "🛒 Shopping List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              shoppingList.isEmpty
                  ? const Text("Your shopping list is empty!")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: shoppingList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(shoppingList[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeFromShoppingList(shoppingList[index]),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
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
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: showShoppingList,
          ),
        ],
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
                        onTap: () {
                          addToRecentlyViewed(filteredRecipes[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                recipe: filteredRecipes[index],
                                toggleFavorite: toggleFavorite,
                                isFavorite: favoriteRecipes.contains(filteredRecipes[index]),
                                addToShoppingList: addToShoppingList, // Pass function to DetailsScreen
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
        ],
      ),
    );
  }
}
