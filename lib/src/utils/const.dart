import 'package:flutter/material.dart';

final List<String> supporatedLocales = ['en', 'ar'];
const String defaultLanguageCode = 'en';
//boxes
const String settingsBox = "settings";
//keys
const String languageCodeKey = "language";

Color hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

const String authBox = "auth";

const String idkey = "userid";
const String nameKey = "name";
const String emailKey = "email";
const String ipKey = "ip";