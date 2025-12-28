import 'package:flutter/material.dart';
import 'App_Bar.dart';
import 'PrefsPage.dart';

class SettingPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingPage> {
  late bool darkMode;
  double textSize = 16.0;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    darkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(name: "smartStore"),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Mode sombre"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
              widget.onThemeChanged(value); //theme ghadi itchanga global
            },
            secondary: const Icon(Icons.dark_mode),
          ),

          const Divider(),

          ListTile(
            title: const Text("Taille du texte"),
            subtitle: Text(textSize.toStringAsFixed(1)),
          ),

          Slider(
            value: textSize,
            min: 10,
            max: 30,
            divisions: 20,
            label: textSize.toStringAsFixed(1),
            onChanged: (value) {
              setState(() {
                textSize = value;
              });
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text("Notifications"),
            subtitle: const Text("Activer / Désactiver les alertes"),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("À propos"),
            subtitle: const Text("Version 1.0.0"),
            onTap: () {},
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrefsPage()),
              );
            },
            child: const Text("Aller aux Préférences"),
          ),
        ],
      ),
    );
  }
}
