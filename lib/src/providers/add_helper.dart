import 'dart:io';

class AdHelper {
  static String get favAndFilterAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2692469317826110/6693678856';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2692469317826110/3962793488';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get searchAndWardrobeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2692469317826110/9806927357';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2692469317826110/9722386621';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2692469317826110/5044775011";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2692469317826110/4169294153";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
