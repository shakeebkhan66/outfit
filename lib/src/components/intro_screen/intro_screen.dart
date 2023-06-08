import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final height = MediaQuery.of(context).size.height;
    final List<OnboardingItem> onboardingItems = [
      OnboardingItem(
        imagePath: currentLanguage.languageCode == "ar" ? AppAssets.intro1 : AppAssets.introen1,
        title: 'obtitle1',
        details: 'obsubtitle1',
      ),
      OnboardingItem(
        imagePath: currentLanguage.languageCode == "ar" ? AppAssets.intro2 : AppAssets.introen2,
        title: 'obtitle2',
        details: 'obsubtitle2',
      ),
      OnboardingItem(
        imagePath: AppAssets.intro3,
        title: 'obtitle3',
        details: 'obsubtitle3',
      ),
      OnboardingItem(
        imagePath: AppAssets.intro4,
        title: 'obtitle4',
        details: 'obsubtitle4',
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingItems.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
                print('Swiped to page: $_currentPage');
              },
              itemBuilder: (context, index) {
                final item = onboardingItems[index];
                return Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Image.asset(
                            item.imagePath,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalization.of(context)!.getTranslatedValues(
                                onboardingItems[index].title,
                              )!,
                              style: TextStyle(
                                fontSize: currentLanguage.languageCode == "ar" ? 22.0 : 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              AppLocalization.of(context)!.getTranslatedValues(
                                onboardingItems[index].details,
                              )!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: currentLanguage.languageCode == "ar" && height > 640.0
                                    ? 16.0
                                    : currentLanguage.languageCode == "ar" && height < 641.0
                                        ? 14.0
                                        : height > 640.0
                                            ? 14.0
                                            : 13.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    onboardingItems.length,
                    (index) => Indicator(
                      isActive: index == _currentPage,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 80.0,
                    height: 40.0,
                    child: AppButtonWidget(
                      onTap: () {
                        if (_currentPage == 3) {
                          AuthLocalDataSource.setonBoardingScreen();
                          AppNavigation.to(context, const SocialAuthPage());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      buttonRadius: 4.0,
                      title: _currentPage == 3 ? "done" : "next",
                      titleSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String imagePath;
  final String title;
  final String details;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.details,
  });
}

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 16.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
