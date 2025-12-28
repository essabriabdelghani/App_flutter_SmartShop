import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'HistoryPage.dart';
import '../pages/Panier.dart';

class App_Bar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const App_Bar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(name),
        centerTitle: false,

        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchPage()),
                    ),
                  },
                  icon: Icon(Icons.search),
                ),
                SizedBox(width: 10),

                IconButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Panier()),
                    ),
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // hna implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
