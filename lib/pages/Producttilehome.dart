import 'package:flutter/material.dart';
import 'ProductPage.dart';
import 'App_Bar.dart';
import '../widgets/ProductTile.dart';
import '../widgets/SectionTitle.dart';
import 'Log.dart';

import '../../models/Product.dart';
import '../../services/json_services.dart';

void showProductSheet(
  BuildContext context,
  String image,
  String name,
  double prix,
  String description,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(image, height: 150),
              ),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "$prix MAD",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProducttPage(
                        image: image,
                        name: name,
                        prix: prix,
                        description: description,
                      ),
                    ),
                  );
                },
                child: Text("Voir détails"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class Producttilehome extends StatefulWidget {
  const Producttilehome({super.key});

  @override
  State<Producttilehome> createState() => _ProducttilehomeState();
}

class _ProducttilehomeState extends State<Producttilehome> {
  List<String> categories = [
    "All",
    "Phones",
    "Laptops",
    "Watch",
    "Gaming",
    "manette",
  ];

  int selectedIndex = 0;

  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = JsonService.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(name: "smartShop"),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Sectiontitle(sectiontitle: "Categories"),
          SizedBox(height: 15),

          // CATEGORIES
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? const Color.fromARGB(255, 66, 12, 214)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Colors.white
                            : Colors.black,
                        fontWeight: index == selectedIndex
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 20),
          Sectiontitle(sectiontitle: "Products"),
          SizedBox(height: 20),

          FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Erreur de chargement"));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("Aucun produit"));
              }

              final products = snapshot.data!;

              final filteredProducts = categories[selectedIndex] == "All"
                  ? products
                  : products
                        .where((p) => p.category == categories[selectedIndex])
                        .toList();

              return Column(
                children: filteredProducts.map((product) {
                  return Column(
                    children: [
                      ProductTile(
                        imagepath: product.imagepath,
                        name: product.name,
                        prix: product.prix,
                        onTap: () {
                          Log.actions.add("${product.name} consulté");
                          showProductSheet(
                            context,
                            product.imagepath,
                            product.name,
                            product.prix,
                            product.description,
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
