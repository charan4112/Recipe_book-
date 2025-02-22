import 'package:flutter/material.dart';
import 'dart:ui';

class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) toggleFavorite;
  final bool isFavorite;

  const DetailsScreen({super.key, required this.recipe, required this.toggleFavorite, required this.isFavorite});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late bool isFavorite;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;

    // Initialize animation controller
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start animation on screen load
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleFavoriteStatus() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.toggleFavorite(widget.recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.recipe["name"]!),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFavorite),
                color: Colors.white,
                size: 28,
              ),
            ),
            onPressed: toggleFavoriteStatus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),

            // Fade-in animation for text content
            FadeTransition(
              opacity: _fadeAnimation,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("🍽 Ingredients:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 8),
                      Text(widget.recipe["ingredients"]!, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                      const SizedBox(height: 16),
                      const Text("📖 Instructions:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 8),
                      Text(widget.recipe["instructions"]!, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
