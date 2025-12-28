import 'package:flutter/material.dart';
import 'App_Bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(name: "Mon Profile"),

      body: Padding(
        padding: EdgeInsets.all(30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset("assets/moi.jpg", height: 250),
                  Text(
                    "ESSABRI ABDELGHANI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("IA Engineering Student|LLM|NLP "),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey, thickness: 2),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 5),
                    Text("abdelghaniessabriO1@gmail.com"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 5),
                    Text("0638436048"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.place),
                    SizedBox(width: 5),
                    Text("settat"),
                  ],
                ),
              ],
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => {},
                label: Text("modifier les informations"),
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
