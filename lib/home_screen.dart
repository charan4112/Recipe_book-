import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> favoriteRecipes = [];
  List<Map<String, String>> filteredRecipes = allRecipes;
  String selectedCategory = "All";

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "All") {
        filteredRecipes = allRecipes;
      } else {
        filteredRecipes = allRecipes.where((recipe) => recipe["category"] == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean UI
      appBar: AppBar(
        title: const Text('Recipe Book', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          // Category Filters
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: ["All", "Breakfast", "Lunch", "Dinner", "Desserts"]
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: Colors.deepOrange,
                        backgroundColor: Colors.grey[300],
                        labelStyle: TextStyle(color: selectedCategory == category ? Colors.white : Colors.black),
                        onSelected: (_) => filterByCategory(category),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          // Recipe List
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(child: Text("No recipes found!", style: TextStyle(fontSize: 18, color: Colors.grey)))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: filteredRecipes.length,
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
                            builder: (context) => DetailsScreen(recipe: filteredRecipes[index]),
                          ),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 6,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.asset(
                                  filteredRecipes[index]["image"]!,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
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
