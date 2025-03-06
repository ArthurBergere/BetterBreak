import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> phrases = [
    "Votre outie est vraiment doué pour la cuisine.",
    "Vous avez un talent naturel pour le dessin.",
    "Vous avez un bon sens de l'humour."
  ];
  int _currentPhraseIndex = 0;
  bool _isPlaying = false;

  void _startMeditation() {
    setState(() {
      _isPlaying = true;
    });
    int count = 0;
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (count >= phrases.length) {
        timer.cancel();
        setState(() {
          _isPlaying = false;
        });
      } else {
        setState(() {
          _currentPhraseIndex = count;
        });
        count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isPlaying ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Text(
                phrases[_currentPhraseIndex],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isPlaying ? null : _startMeditation,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text("Débuter mes 5 minutes wellness du jour"),
            ),
          ],
        ),
      ),
    );
  }
}