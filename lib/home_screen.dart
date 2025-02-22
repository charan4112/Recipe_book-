import 'package:flutter/material.dart';
import 'details_screen.dart';

// Dummy Recipe Data
final List<Map<String, String>> recipes = [
  {
    "name": "Chicken Biryani",
    "image": "assets/Chicken_Biriyani.JPG",
    "ingredients": "Rice, Chicken, Spices, Yogurt",
    "instructions": "Cook chicken with spices, add rice, cook until done."
  },
  {
    "name": "Chicken Curry",
    "image": "assets/Chicken_Curry.JPG",
    "ingredients": "Chicken, Tomatoes, Onions, Spices",
    "instructions": "Fry onions, add tomatoes, spices, and chicken. Cook well."
  },
  {
    "name": "Fish Starter",
    "image": "assets/Fish_Starter.JPG",
    "ingredients": "Fish, Lemon, Garlic, Spices",
    "instructions": "Marinate fish, grill until golden brown."
  },
  {
    "name": "Ice Cream",
    "image": "assets/Icecream.JPG",
    "ingredients": "Milk, Sugar, Cream, Fruits",
    "instructions": "Blend ingredients, freeze for 4 hours."
  },
  {
    "name": "Shrimp Starter",
    "image": "assets/Shrimp_Starter.JPG",
    "ingredients": "Shrimp, Garlic, Butter, Lemon",
    "instructions": "Sauté shrimp in butter and garlic, squeeze lemon on top."
  },
  {
    "name": "Milkshake",
    "image": "assets/Milkshake.JPG",
    "ingredients": "Milk, Ice Cream, Sugar, Flavors",
    "instructions": "Blend all ingredients until smooth."
  }
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredRecipes = List.from(recipes);

  void searchRecipes(String query) {
    setState(() {
      filteredRecipes = recipes
          .where((recipe) =>
              recipe["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Recipes...",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: searchRecipes,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(filteredRecipes[index]["image"]!,
                            width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(
                        filteredRecipes[index]["name"]!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(recipe: filteredRecipes[index]),
                          ),
                        );
                      },
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
