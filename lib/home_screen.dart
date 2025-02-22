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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Book')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(recipes[index]["image"]!, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(recipes[index]["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(recipe: recipes[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
