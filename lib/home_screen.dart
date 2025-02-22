import 'package:flutter/material.dart';
import 'details_screen.dart';

final List<Map<String, String>> recipes = [
  {
    "name": "Chicken Biryani",
    "image": "assets/Chicken_Biriyani.JPG",
    "category": "Rice",
    "ingredients": "Rice, Chicken, Spices, Yogurt",
    "instructions": "Cook chicken with spices, add rice, cook until done."
  },
  {
    "name": "Chicken Curry",
    "image": "assets/Chicken_Curry.JPG",
    "category": "Curry",
    "ingredients": "Chicken, Tomatoes, Onions, Spices",
    "instructions": "Fry onions, add tomatoes, spices, and chicken. Cook well."
  },
  {
    "name": "Fish Starter",
    "image": "assets/Fish_Starter.JPG",
    "category": "Starters",
    "ingredients": "Fish, Lemon, Garlic, Spices",
    "instructions": "Marinate fish, grill until golden brown."
  },
  {
    "name": "Ice Cream",
    "image": "assets/Icecream.JPG",
    "category": "Dessert",
    "ingredients": "Milk, Sugar, Cream, Fruits",
    "instructions": "Blend ingredients, freeze for 4 hours."
  },
  {
    "name": "Shrimp Starter",
    "image": "assets/Shrimp_Starter.JPG",
    "category": "Starters",
    "ingredients": "Shrimp, Garlic, Butter, Lemon",
    "instructions": "Sauté shrimp in butter and garlic, squeeze lemon on top."
  },
  {
    "name": "Milkshake",
    "image": "assets/Milkshake.JPG",
    "category": "Beverage",
    "ingredients": "Milk, Ice Cream, Sugar, Flavors",
    "instructions": "Blend all ingredients until smooth."
  }
];

final List<String> categories = [
  "All",
  "Rice",
  "Curry",
  "Starters",
  "Dessert",
  "Beverage"
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredRecipes = List.from(recipes);

  void filterRecipes(String query) {
    setState(() {
      filteredRecipes = recipes.where((recipe) {
        bool matchesSearch =
            recipe["name"]!.toLowerCase().contains(query.toLowerCase());
        bool matchesCategory =
            selectedCategory == "All" || recipe["category"] == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      filterRecipes(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      appBar: AppBar(
        title: const Text('Recipe Book',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              // Add functionality for Favorites
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Recipes...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: filterRecipes,
            ),
            const SizedBox(height: 10),

            // Category Filters
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(categories[index],
                          style: TextStyle(
                              color: selectedCategory == categories[index]
                                  ? Colors.white
                                  : Colors.black)),
                      selected: selectedCategory == categories[index],
                      selectedColor: Colors.deepOrange,
                      onSelected: (bool selected) {
                        if (selected) changeCategory(categories[index]);
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Recipe Grid
            Expanded(
              child: GridView.builder(
                itemCount: filteredRecipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjust height of grid items
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(recipe: filteredRecipes[index]),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            child: Image.asset(filteredRecipes[index]["image"]!,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredRecipes[index]["name"]!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
