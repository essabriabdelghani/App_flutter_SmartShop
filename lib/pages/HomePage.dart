import 'package:flutter/material.dart';
import 'App_Bar.dart';
import '../widgets/ProductCard.dart';

class HomePage extends StatelessWidget {
  List products = [
    {
      "name": "phone",
      "image": "assets/phone.png",
      "prix": 752,
      "description": "is a good product is a good product",
    },
    {
      "name": "Laptop",
      "image": "assets/laptop.png",
      "prix": 1025,
      "description": "is a good product is a good product",
    },
    {
      "name": "watch",
      "image": "assets/watch.png",
      "prix": 520,
      "description": "is a good product is a good product",
    },
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(name: "smartStore"),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: products
            .map(
              (p) => Productcard(
                image: p['image'],
                description: p['description'],
                name: p['name'],
                prix: p['prix'],
              ),
            )
            .toList(),
      ),
    );
  }
}
