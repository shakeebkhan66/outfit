import 'package:hive/hive.dart';
import 'package:outfit/src/utils/const.dart';

//AuthLocalDataSource will communicate with local database (hive)
class AuthLocalDataSource {
  static String getUserid() {
    return Hive.box(authBox).get(idkey, defaultValue: "");
  }

  static Future<void> setUserid(String userid) async {
    await Hive.box(authBox).put(idkey, userid);
  }

  static String getUserName() {
    return Hive.box(authBox).get(nameKey, defaultValue: "");
  }

  static Future<void> setUserName(String name) async {
    await Hive.box(authBox).put(nameKey, name);
  }

  static String getEmail() {
    return Hive.box(authBox).get(emailKey, defaultValue: "");
  }

  static Future<void> setEmail(String email) async {
    await Hive.box(authBox).put(emailKey, email);
  }

  static bool getLang() {
    return Hive.box(langBox).get(langKey, defaultValue: false);
  }

  static Future<void> setLan(bool lang) async {
    await Hive.box(langBox).put(langKey, lang);
  }

  static Future<void> clearData() async {
    await setEmail("");
    await setUserid("");
    await setUserName("");
  }

  static bool getTutorial1() {
    return Hive.box(tutorialBox).get(tutorial1, defaultValue: false);
  }

  static Future<void> setTutorial1() async {
    await Hive.box(tutorialBox).put(tutorial1, true);
  }

  static bool getTutorial2() {
    return Hive.box(tutorialBox).get(tutorial2, defaultValue: false);
  }

  static Future<void> setTutorial2() async {
    await Hive.box(tutorialBox).put(tutorial2, true);
  }

  static bool getTutorial3() {
    return Hive.box(tutorialBox).get(tutorial3, defaultValue: false);
  }

  static Future<void> setTutorial3() async {
    await Hive.box(tutorialBox).put(tutorial3, true);
  }

  static bool getTutorial4() {
    return Hive.box(tutorialBox).get(tutorial4, defaultValue: false);
  }

  static Future<void> setTutorial4() async {
    print('finished');
    await Hive.box(tutorialBox).put(tutorial4, true);
  }

  static bool getTutorial6() {
    return Hive.box(tutorialBox).get(tutorial6, defaultValue: false);
  }

  static Future<void> setTutorial6() async {
    await Hive.box(tutorialBox).put(tutorial6, true);
  }

  static bool getonBoardingScreen() {
    return Hive.box(authBox).get(onboardingKey, defaultValue: false);
  }

  static Future<void> setonBoardingScreen() async {
    await Hive.box(authBox).put(onboardingKey, true);
  }
}
