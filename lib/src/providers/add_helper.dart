import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

class NativeAdsProvider extends ChangeNotifier {
  NativeAd? nativeAd;

  NativeAd? get getNativeAd => nativeAd;

  setNativeAds() {
    print("i am calling");
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeAd = ad as NativeAd;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    nativeAd!.load();
  }
}
