import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  static onLogin(String loginType) async {
    print("Sending data");
    await _firebaseAnalytics.logLogin(
      loginMethod: loginType,
    );
  }
}