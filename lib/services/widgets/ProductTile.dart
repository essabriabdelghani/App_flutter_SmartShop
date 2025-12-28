import 'package:flutter/material.dart';
import '../db_service.dart';

class ProductTile extends StatefulWidget {
  final String name;
  final String imagepath;
  final double prix;
  final VoidCallback? onTap;
  final String? category;

  const ProductTile({
    super.key,
    required this.imagepath,
    required this.name,
    required this.prix,
    this.onTap,
    this.category,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final DBService dbService = DBService();
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final exists = await dbService.isFavorite(widget.name);
    setState(() {
      isFavorite = exists;
      isLoading = false;
    });
  }

  Future<void> toggleFavorite() async {
    if (isFavorite) {
      await dbService.removeFavorite(widget.name);
    } else {
      await dbService.addFavorite({
        "name": widget.name,
        "price": widget.prix,
        "imagePath": widget.imagepath,
      });
    }

    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? "Ajouté aux favoris ❤️" : "Retiré des favoris",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(widget.imagepath, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${widget.prix} DH",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
