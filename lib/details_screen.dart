import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) toggleFavorite;
  final bool isFavorite;
  final Function(List<String>) addToShoppingList;

  const DetailsScreen({super.key, required this.recipe, required this.toggleFavorite, required this.isFavorite, required this.addToShoppingList});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late bool isFavorite;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void toggleFavoriteStatus() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.toggleFavorite(widget.recipe);
    _animationController.forward().then((_) => _animationController.reverse());
  }

  void addIngredientsToShoppingList() {
    List<String> ingredientsList = widget.recipe["ingredients"]!.split(",");
    widget.addToShoppingList(ingredientsList);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added ingredients to shopping list!"), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe["name"]!),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.recipe["name"]!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.recipe["image"]!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ScaleTransition(
            scale: _scaleAnimation,
            child: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 36),
              onPressed: toggleFavoriteStatus,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: addIngredientsToShoppingList,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text("🛒 Add Ingredients to Shopping List"),
          ),
        ],
      ),
    );
  }
}
