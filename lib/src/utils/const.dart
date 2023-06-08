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
const String langBox = "langBox";
const String tutorialBox = "tutorialBox";

const String idkey = "userid";
const String nameKey = "name";
const String emailKey = "email";
const String ipKey = "ip";
const String langKey = "lang";
const String onboardingKey = "onboardingKey";

const String tutorial1 = "tutorial1";
const String tutorial2 = "tutorial2";
const String tutorial3 = "tutorial3";
const String tutorial4 = "tutorial4";
const String tutorial6 = "tutorial6";
