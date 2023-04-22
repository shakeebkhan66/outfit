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

  static String getIp() {
    return Hive.box(authBox).get(ipKey, defaultValue: "");
  }

  static Future<void> setIp(String ip) async {
    await Hive.box(authBox).put(ipKey, ip);
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
}
