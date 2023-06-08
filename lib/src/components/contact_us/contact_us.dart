import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Contact us"),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppAssets.contactus),
              Text(
                AppLocalization.of(context)!.getTranslatedValues("contactus")!,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 22.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            AppLocalization.of(context)!.getTranslatedValues("lovetohear")!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              AppLocalization.of(context)!.getTranslatedValues("weatheryouare")!,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  UrlLaunchers.openFacebookProfile();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        AppAssets.facebookblack,
                        height: 30.0,
                      ),
                    ),
                    const Text("Facebook"),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  UrlLaunchers.openInstagramProfile();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        AppAssets.instagramblack,
                        height: 30.0,
                      ),
                    ),
                    const Text("Instagram"),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class UrlLaunchers {
  UrlLaunchers._();
  static void openFacebookProfile() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/wearrwhat';
    } else {
      fbProtocolUrl = 'fb://page/wearrwhat';
    }
    const facebookUrl = 'https://www.facebook.com/wearrwhat/';
    if (await canLaunchUrl(Uri.parse(fbProtocolUrl))) {
      await launchUrl(Uri.parse(facebookUrl), mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(Uri.parse(facebookUrl), mode: LaunchMode.externalApplication);
    }
  }

// Open Instagram profile
  static void openInstagramProfile() async {
    const instagramUrl = 'https://www.instagram.com/wearrwhat/';
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }
}
