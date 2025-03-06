import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.teal.shade50,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
    bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
  ),
);