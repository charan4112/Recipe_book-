import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;
  const DetailsScreen({super.key, required this.recipe});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe["name"]!),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Column(
        children: [
          // Recipe Image
          Hero(
            tag: widget.recipe["name"]!,
            child: Image.asset(widget.recipe["image"]!, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          // Tab Bar
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.black54,
            tabs: const [
              Tab(text: "Ingredients"),
              Tab(text: "Steps"),
              Tab(text: "Nutrition"),
            ],
          ),
          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Ingredients Tab
                ListView(
                  padding: const EdgeInsets.all(10),
                  children: widget.recipe["ingredients"]!.split(",").map((ingredient) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.green),
                        title: Text(ingredient),
                      ),
                    );
                  }).toList(),
                ),
                // Steps Tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.recipe["steps"]!, style: const TextStyle(fontSize: 16)),
                ),
                // Nutrition Tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.recipe["nutrition"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
