import 'package:flutter/material.dart';

import 'App_Bar.dart';
import 'Log.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
       appBar: App_Bar(name: "Historique des actions"),

      body: Log.actions.isEmpty
          ? const Center(
              child: Text(
                "Aucune action enregistrée.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: Log.actions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(Log.actions[index]),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        Log.actions.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          setState(() {
            Log.actions.clear();
          });
        },
      ),
    );
  }
}


