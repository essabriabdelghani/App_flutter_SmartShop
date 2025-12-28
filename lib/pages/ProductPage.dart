import 'package:flutter/material.dart';
import 'App_Bar.dart';
import '../../services/db_service.dart';
import '../widgets/CartService.dart';

class ProducttPage extends StatefulWidget {
  final String image;
  final String name;
  final double prix;
  final String description;
  final String? category;

  const ProducttPage({
    super.key,
    required this.image,
    required this.name,
    required this.prix,
    required this.description,
    this.category,
  });

  @override
  State<ProducttPage> createState() => _ProductpageState();
}

class _ProductpageState extends State<ProducttPage> {
  bool addedToCart = false;
  bool isFavorite = false;

  final DBService dbService = DBService();

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  // ghadi n tchekiw wax product favorite wla la

  Future<void> checkFavorite() async {
    final exists = await dbService.isFavorite(widget.name);
    setState(() {
      isFavorite = exists;
    });
  }

  // Toggle favorite

  Future<void> toggleFavorite() async {
    if (isFavorite) {
      await dbService.removeFavorite(widget.name);
    } else {
      await dbService.addFavorite({
        'name': widget.name,
        'price': widget.prix,
        'imagePath': widget.image,
      });
    }

    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? "Ajouté aux favoris ❤️" : "Retiré des favoris 🤍",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(name: widget.name),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(widget.image, height: 250)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 7),
                Text(widget.description),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star_half, color: Colors.amber),
                    Icon(Icons.star_border, color: Colors.amber),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.prix.toStringAsFixed(2)} DH',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ----------------------------
                // Add to cart
                // ----------------------------
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (addedToCart) {
                        CartService.removeFromCart(widget.name);
                      } else {
                        CartService.addToCart({
                          "name": widget.name,
                          "image": widget.image,
                          "prix": widget.prix,
                          "description": widget.description,
                          "category": widget.category ?? '',
                        });
                      }
                      addedToCart = !addedToCart;
                    });
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Ajouter au panier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),

                const SizedBox(width: 20),

                // Favorite button lkhalfiya red
                InkWell(
                  onTap: toggleFavorite,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFavorite ? Colors.red : Colors.white,
                      border: Border.all(color: Colors.red),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.white : Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
