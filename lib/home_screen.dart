import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> recipes = [
    {
      "title": "Chicken Biriyani",
      "ingredients": "Chicken, Basmati Rice, Spices, Saffron, Yogurt",
      "instructions": "1. Marinate chicken.\n2. Cook rice separately.\n3. Layer and slow cook.",
      "category": "Dinner",
      "image": "assets/Chicken_Biriyani.JPG"
    },
    {
      "title": "Chicken Curry",
      "ingredients": "Chicken, Curry Powder, Coconut Milk, Onion, Garlic, Ginger",
      "instructions": "1. Sauté onion, garlic, and ginger.\n2. Add chicken and curry powder.\n3. Pour in coconut milk and simmer.",
      "category": "Lunch",
      "image": "assets/Chicken_Curry.JPG"
    },
    {
      "title": "Fish Starter",
      "ingredients": "Fish, Turmeric, Garlic, Lemon, Spices",
      "instructions": "1. Marinate fish.\n2. Shallow fry until golden brown.\n3. Serve with mint chutney.",
      "category": "Starter",
      "image": "assets/Fish_Starter.JPG"
    },
    {
      "title": "Ice Cream",
      "ingredients": "Milk, Cream, Sugar, Strawberries, Vanilla",
      "instructions": "1. Mix ingredients.\n2. Freeze until firm.\n3. Serve with toppings.",
      "category": "Dessert",
      "image": "assets/Icecream.JPG"
    },
    {
      "title": "Shrimp Starter",
      "ingredients": "Shrimp, Chili Powder, Garlic, Lemon, Butter",
      "instructions": "1. Sauté shrimp in garlic butter.\n2. Sprinkle chili powder.\n3. Garnish with coriander.",
      "category": "Starter",
      "image": "assets/Shrimp_Starter.JPG"
    },
    {
      "title": "Milkshake",
      "ingredients": "Milk, Ice Cream, Chocolate, Whipped Cream, Banana",
      "instructions": "1. Blend all ingredients.\n2. Pour into glass.\n3. Top with whipped cream and cherries.",
      "category": "Beverage",
      "image": "assets/Milkshake.JPG"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book")),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              leading: Image.asset(
                recipes[index]["image"]!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                recipes[index]["title"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Category: ${recipes[index]["category"]}"),
              trailing: Icon(Icons.arrow_forward),
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
