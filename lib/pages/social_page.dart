import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  late final WebViewController _controller;
  String currentUrl = 'https://www.instagram.com';
  int socialBurstTimeLimit = 10;
  Set<int> selectedHours = {};
  bool isBlocked = false;

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
      selectedHours = (prefs.getStringList('selectedHours') ?? [])
          .map((e) => int.parse(e))
          .toSet();
    });
  }

  Future<void> _saveUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('socialBurstTimeLimit', socialBurstTimeLimit);
    await prefs.setStringList('selectedHours', selectedHours.map((e) => e.toString()).toList());
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réseaux Sociaux'),
        actions: [
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
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 30, color: Colors.purple),
                  onPressed: () => _loadUrl('https://www.instagram.com'),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.language, size: 30, color: Colors.blue),
                  onPressed: () => _loadUrl('https://www.twitter.com'),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.business, size: 30, color: Colors.blueGrey),
                  onPressed: () => _loadUrl('https://www.linkedin.com'),
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
