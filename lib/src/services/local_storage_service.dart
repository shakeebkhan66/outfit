import 'package:hive/hive.dart';
import 'package:outfit/src/utils/const.dart';

class SettingsLocalDataSource {
  String? languageCode() {
    return Hive.box(settingsBox).get(languageCodeKey, defaultValue: defaultLanguageCode); //
  }

  Future<void> setLanguageCode(String value) async {
    Hive.box(settingsBox).put(languageCodeKey, value);
  }
}
