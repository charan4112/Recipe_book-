import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;

  DetailsScreen({required this.recipe});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false; // Track if the recipe is marked as favorite

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe["title"]!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Title
            Text(
              widget.recipe["title"]!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Ingredients Section
            Text(
              "Ingredients:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.recipe["ingredients"]!),
            SizedBox(height: 10),

            // Instructions Section
            Text(
              "Instructions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.recipe["instructions"]!),
            SizedBox(height: 20),

            // Favorite Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  label: Text(
                      isFavorite ? "Added to Favorites" : "Add to Favorites"),
                ),

                // Back Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
