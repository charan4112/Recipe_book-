import 'home_screen.dart'; // Import HomeScreen

class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) toggleFavorite;
  final bool isFavorite;

  const DetailsScreen({super.key, required this.recipe, required this.toggleFavorite, required this.isFavorite});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.recipe["name"]!),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
            onPressed: toggleFavoriteStatus,
          ),
        ],
      ),
      body: // Existing body content
    );
  }
}
