import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/CartService.dart';

class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});

  @override
  State<PrefsPage> createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {

  TextEditingController usernameController = TextEditingController();
  bool isDark = false;
  int cartCount = 0;
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }


  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = prefs.getString("username") ?? "";
      isDark = prefs.getBool("darkmode") ?? false;
      cartCount = prefs.getInt("cart") ?? 0;
      isLoading = false; 
    });
  }


  Future<void> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", usernameController.text);
    await prefs.setBool("darkmode", isDark);
    await prefs.setInt("cart", CartService().cartTotalItems());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Préférences sauvegardées !")),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Préférences")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Préférences")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Nom d'utilisateur",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mode sombre"),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nombre d'articles dans le panier"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (cartCount > 0) cartCount--;
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(cartCount.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cartCount++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: savePrefs,
              child: Text("Sauvegarder"),
            ),
          ],
        ),
      ),
    );
  }
}
