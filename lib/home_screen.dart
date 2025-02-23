import 'package:flutter/material.dart';
import '../screens/details_screen.dart';
import '../screens/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  List<Map<String, String>> allRecipes = [
    {
      "name": "Chicken Biriyani",
      "image": "assets/Chicken_Biriyani.JPG",
      "category": "Dinner"
    },
    {
      "name": "Chicken Curry",
      "image": "assets/Chicken_Curry.JPG",
      "category": "Lunch"
    },
    {
      "name": "Fish Starter",
      "image": "assets/Fish_Starter.JPG",
      "category": "Starter"
    },
    {
      "name": "Shrimp Starter",
      "image": "assets/Shrimp_Starter.JPG",
      "category": "Starter"
    },
    {"name": "Icecream", "image": "assets/Icecream.JPG", "category": "Dessert"},
    {
      "name": "Milkshake",
      "image": "assets/Milkshake.JPG",
      "category": "Beverage"
    },
  ];

  List<Map<String, String>> favoriteRecipes = [];

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void toggleFavorite(Map<String, String> recipe) {
    setState(() {
      favoriteRecipes.contains(recipe)
          ? favoriteRecipes.remove(recipe)
          : favoriteRecipes.add(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedRecipes = selectedCategory == "All"
        ? allRecipes
        : allRecipes
            .where((recipe) => recipe["category"] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FavoritesScreen(favoriteRecipes: favoriteRecipes),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: ["All", "Breakfast", "Lunch", "Dinner", "Dessert"]
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: Colors.deepOrange,
                        backgroundColor: Colors.grey[300],
                        labelStyle: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.black),
                        onSelected: (_) => filterByCategory(category),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: displayedRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                          recipe: displayedRecipes[index],
                          toggleFavorite: toggleFavorite),
                    ),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 6,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.asset(displayedRecipes[index]["image"]!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(displayedRecipes[index]["name"]!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
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
