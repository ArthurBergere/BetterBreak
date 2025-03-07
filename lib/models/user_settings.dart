import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserSettings {
  int socialBurstTimeLimit;
  int remainingTime;
  Set<int> selectedHours;

  UserSettings({this.socialBurstTimeLimit = 10, this.remainingTime = 600, this.selectedHours = const {}});

  static Future<UserSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    int storedTimeLimit = prefs.getInt('socialBurstTimeLimit') ?? 10;
    int storedRemainingTime = prefs.getInt('remainingTime') ?? (storedTimeLimit * 60);
    return UserSettings(
      socialBurstTimeLimit: storedTimeLimit,
      remainingTime: storedRemainingTime,
      selectedHours: (prefs.getStringList('selectedHours') ?? [])
          .map((e) => int.parse(e))
          .toSet(),
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('socialBurstTimeLimit', socialBurstTimeLimit);
    await prefs.setInt('remainingTime', remainingTime);
    await prefs.setStringList('selectedHours', selectedHours.map((e) => e.toString()).toList());
  }
}