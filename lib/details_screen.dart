class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) toggleFavorite;
  final bool isFavorite;
  final Function(List<String>) addToShoppingList;

  const DetailsScreen({super.key, required this.recipe, required this.toggleFavorite, required this.isFavorite, required this.addToShoppingList});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void toggleFavoriteStatus() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.toggleFavorite(widget.recipe);
  }

  void addIngredientsToShoppingList() {
    List<String> ingredientsList = widget.recipe["ingredients"]!.split(",");
    widget.addToShoppingList(ingredientsList);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added ingredients to shopping list!"), duration: Duration(seconds: 2)),
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
          ElevatedButton(
            onPressed: addIngredientsToShoppingList,
            child: const Text("🛒 Add Ingredients to Shopping List"),
          ),
        ],
      ),
    );
  }
}
