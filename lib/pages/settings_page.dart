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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Durée des réseaux sociaux (min) :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: settings.socialBurstTimeLimit.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: const Icon(Icons.timer),
                    ),
                    onChanged: (value) {
                      final int? newValue = int.tryParse(value);
                      if (newValue != null) {
                        setState(() {
                          settings.socialBurstTimeLimit = newValue;
                          if (settings.remainingTime > newValue * 60) {
                            settings.remainingTime = newValue * 60;
                          }
                        });
                        settings.save();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      "Temps restant : ${settings.remainingTime ~/ 60} min ${settings.remainingTime % 60} sec",
                      style: const TextStyle(fontSize: 14, color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sélection des heures autorisées :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2,
                      ),
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
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: selected ? Colors.teal : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: Colors.teal.withOpacity(0.5),
                                        blurRadius: 6,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                '$hour h',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
