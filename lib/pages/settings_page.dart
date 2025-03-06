import 'package:flutter/material.dart';
import '../models/user_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserSettings settings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    settings = await UserSettings.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: settings == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  title: const Text('Durée des réseaux sociaux (min) :'),
                  trailing: DropdownButton<int>(
                    value: settings.socialBurstTimeLimit,
                    items: [2, 5, 10]
                        .map((e) => DropdownMenuItem(value: e, child: Text('$e min')))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        settings.socialBurstTimeLimit = value!;
                      });
                      settings.save();
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 2),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      int hour = index + 8;
                      bool selected = settings.selectedHours.contains(hour);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selected) {
                              settings.selectedHours.remove(hour);
                            } else {
                              settings.selectedHours.add(hour);
                            }
                          });
                          settings.save();
                        },
                        child: Card(
                          color: selected ? Colors.teal : Colors.grey[300],
                          child: Center(child: Text('$hour h')),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}