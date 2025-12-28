import 'package:flutter/material.dart';
import '../../pages/ProductPage.dart';

class Productcard extends StatelessWidget {
  final String image;
  final String name;
  final double prix;
  final String description;

  const Productcard({
    super.key,
    required this.image,
    required this.description,
    required this.name,
    required this.prix,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 190, child: Image.asset(image)),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('\$${prix.toStringAsFixed(2)} DH'),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProducttPage(
                  image: image,
                  name: name,
                  prix: prix,
                  description: description,
                ),
              ),
            ),

            child: Text("details"),
          ),
        ],
      ),
    );
  }
}
