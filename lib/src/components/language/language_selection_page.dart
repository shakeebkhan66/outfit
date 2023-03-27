import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  var _selectedLanguage = 'en_us';

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: padding.top + 70),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 45),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Text(
              'Choose Language',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectedLanguage = 'en_us';
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.only(top: 45, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: _selectedLanguage == 'en_us'
                      ? Border.all(width: 1, color: AppColors.primaryColor)
                      : null,
                  boxShadow: AppShadow.primaryShadow,
                ),
                padding: const EdgeInsets.fromLTRB(44, 23, 44, 24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    AppAssets.english,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'English',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectedLanguage = 'ar';
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: _selectedLanguage == 'ar'
                      ? Border.all(width: 1, color: AppColors.primaryColor)
                      : null,
                  boxShadow: AppShadow.primaryShadow,
                ),
                padding: const EdgeInsets.fromLTRB(44, 23, 44, 24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    AppAssets.arabic,
                    width: 65,
                    height: 65,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Arabic',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: AppButtonWidget(
                onTap: () {
                  AppNavigation.to(context, const SocialAuthPage());
                },
                title: 'Continue',
                buttonRadius: 15,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
