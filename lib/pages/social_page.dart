import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  late final WebViewController _controller;
  String currentUrl = 'https://www.instagram.com';
  int socialBurstTimeLimit = 10;
  int remainingTime = 600;
  bool isBlocked = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(currentUrl));
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      socialBurstTimeLimit = prefs.getInt('socialBurstTimeLimit') ?? 10;
      remainingTime = prefs.getInt('remainingTime') ?? (socialBurstTimeLimit * 60);
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('remainingTime', remainingTime);
      } else {
        _blockSocialMedia();
        timer.cancel();
      }
    });
  }

  void _loadUrl(String url) {
    if (isBlocked) return;
    setState(() {
      currentUrl = url;
    });
    _controller.loadRequest(Uri.parse(url));
  }

  void _blockSocialMedia() {
    setState(() {
      isBlocked = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réseaux Sociaux'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "${remainingTime ~/ 60} min ${remainingTime % 60} sec",
                style: const TextStyle(fontSize: 14, color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 30, color: Colors.purple),
                      onPressed: () => _loadUrl('https://www.instagram.com'),
                    ),
                    const Text("Instagram", style: TextStyle(fontSize: 12))
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language, size: 30, color: Colors.blue),
                      onPressed: () => _loadUrl('https://www.twitter.com'),
                    ),
                    const Text("Twitter", style: TextStyle(fontSize: 12))
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.business, size: 30, color: Colors.blueGrey),
                      onPressed: () => _loadUrl('https://www.linkedin.com'),
                    ),
                    const Text("LinkedIn", style: TextStyle(fontSize: 12))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isBlocked
                ? Center(
                    child: Text(
                      "Temps écoulé. Accès bloqué.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
