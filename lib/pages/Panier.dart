import 'package:flutter/material.dart';
import '../pages/App_Bar.dart';
import '../widgets/CartService.dart';
import '../widgets/SectionTitle.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.getCartItems();

    return Scaffold(
      appBar: App_Bar(name: "Mon Panier"),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                "Votre panier est vide 🛒",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView(
              padding: EdgeInsets.all(20),
              children: [
                Sectiontitle(sectiontitle: "Produits ajoutés"),
                SizedBox(height: 20),

                Column(
                  children: cartItems.map((product) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
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
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                      product['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "${product['prix']} DH",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    CartService.removeFromCart(product['name']);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Produit retiré du panier"),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
