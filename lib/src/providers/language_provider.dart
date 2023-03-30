import 'package:flutter/material.dart';
import 'package:outfit/src/services/local_storage_service.dart';
import 'package:outfit/src/utils/app_utils.dart';

class LanguageProvider extends ChangeNotifier {
  final SettingsLocalDataSource settingsLocalDataSource;
  LanguageProvider(this.settingsLocalDataSource);
  Locale get getAppLanguage => AppUtils.getLocaleFromLanguageCode(settingsLocalDataSource.languageCode()!);

  void changeLanguage(String languageCode) {
    print(languageCode);
    settingsLocalDataSource.setLanguageCode(languageCode);
    notifyListeners();
  }
}