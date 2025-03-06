import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  int socialBurstTimeLimit;
  Set<int> selectedHours;

  UserSettings({this.socialBurstTimeLimit = 10, this.selectedHours = const {}});

  static Future<UserSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return UserSettings(
      socialBurstTimeLimit: prefs.getInt('socialBurstTimeLimit') ?? 10,
      selectedHours: (prefs.getStringList('selectedHours') ?? [])
          .map((e) => int.parse(e))
          .toSet(),
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('socialBurstTimeLimit', socialBurstTimeLimit);
    await prefs.setStringList('selectedHours', selectedHours.map((e) => e.toString()).toList());
  }
}