import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/home/views/outfit_ideas_view.dart';
import 'package:outfit/src/components/home/views/wardrobe_view.dart';
import 'package:outfit/src/components/search/search_page.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/add_helper.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/tutorial_guide.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey searchGuideKey = GlobalKey();
  GlobalKey outfitViewGuideKey = GlobalKey();
  final String email = AuthLocalDataSource.getEmail();
  final bool isShowtutorial = AuthLocalDataSource.getTutorial1();
  final bool isShow45tutorial = AuthLocalDataSource.getTutorial4();
  final ProductsViewModel _productsViewModel = ProductsViewModel();
  late final List<Widget> _pages = [
    OutfitIdeasView(
      productViewModel: _productsViewModel,
      outfitViewGuideKey: outfitViewGuideKey,
    ),
    const WardrobeView(),
  ];

  InterstitialAd? interstitialAd;
  Future _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.searchAndWardrobeAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );
          setState(() {
            interstitialAd = ad;
          });
          interstitialAd!.show();
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("This is initstate i am calling it now");
    print(isShow45tutorial);
    TutorialGuide tutorialGuide = TutorialGuide(
      searchGuideKey: searchGuideKey,
      outfitViewGuideKey: outfitViewGuideKey,
    );
    tutorialGuide.createSearchTutorial(
      onClickTarget: (target) {
        AppNavigation.to(
          context,
          SearchPage(
            productsViewModel: _productsViewModel,
            callback: (loadAd) async {
              tutorialGuide.createoutfitTutorial(context);
              if (!isShow45tutorial) {
                Future.delayed(Duration.zero, tutorialGuide.showoutfitTutorial(context));
              }
              await _loadInterstitialAd();
            },
          ),
        );
      },
    );

    if (!isShowtutorial) {
      Future.delayed(Duration.zero, tutorialGuide.showSearchTutorial(context));
    }
    Provider.of<NativeAdsProvider>(context, listen: false).setNativeAds();
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final page = Provider.of<ProductsViewModel>(context);
    final keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    TutorialGuide tutorialGuide = TutorialGuide(
      outfitViewGuideKey: outfitViewGuideKey,
    );
    Widget? floatingActionButton;
    if (!(keyboardIsOpened || page.getIndex != 0)) {
      floatingActionButton = Transform.scale(
        key: searchGuideKey,
        scale: 1.2,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.search),
          onPressed: () {
            AppNavigation.to(
                context,
                SearchPage(
                  productsViewModel: _productsViewModel,
                  callback: (loadAd) async {
                    final bool isShow4tutorial = AuthLocalDataSource.getTutorial4();
                    print("this is floating action button");
                    print(isShow4tutorial);
                    tutorialGuide.createoutfitTutorial(context);
                    // if (!isShow4tutorial) {
                    Future.delayed(Duration.zero, tutorialGuide.showoutfitTutorial(context));
                    // }
                    await _loadInterstitialAd();
                  },
                ));
          },
        ),
      );
    } else {
      floatingActionButton = const FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        hoverColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
      );
    }
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _pages[page.getIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 15,
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(color: Color(0xFFFFFBF9)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: currentLanguage.languageCode == "en" ? 20.0 : 0.0,
                  left: currentLanguage.languageCode == "en" ? 0.0 : 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    page.setSetIndex(0);
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      AppAssets.outfitIdeas,
                      width: 24,
                      height: 26,
                      color: page.getIndex == 0 ? AppColors.primaryColor : AppColors.blackColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalization.of(context)!.getTranslatedValues('outfitideas')!,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: page.getIndex == 0 ? AppColors.primaryColor : AppColors.blackColor,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: currentLanguage.languageCode == "en" ? 20 : 0.0,
                  right: currentLanguage.languageCode == "en" ? 0 : 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    page.setSetIndex(1);
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      AppAssets.wardrobe,
                      width: 16.33,
                      height: 23.56,
                      color: page.getIndex == 1 ? AppColors.primaryColor : AppColors.blackColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalization.of(context)!.getTranslatedValues('mywardrobe')!,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: page.getIndex == 1 ? AppColors.primaryColor : AppColors.blackColor,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        // child: BottomNavigationBar(
        //   elevation: 0,
        //   backgroundColor: const Color(0xFFFFFBF9),
        //   onTap: _selectPage,
        //   currentIndex: _pageIndex,
        //   selectedLabelStyle: GoogleFonts.roboto(fontSize: 10),
        //   unselectedLabelStyle: GoogleFonts.roboto(fontSize: 10),
        //   selectedItemColor: AppColors.primaryColor,
        //   unselectedItemColor: AppColors.blackColor,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.only(bottom: 4.0),
        //         child: Image.asset(
        //           AppAssets.outfitIdeas,
        //           width: 24,
        //           height: 26,
        //           color: _pageIndex == 0
        //               ? AppColors.primaryColor
        //               : AppColors.blackColor,
        //         ),
        //       ),
        //       label: 'Outfit ideas',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Padding(
        //         padding: const EdgeInsets.only(bottom: 4.0),
        //         child: Image.asset(
        //           AppAssets.wardrobe,
        //           width: 16.33,
        //           height: 23.56,
        //           color: _pageIndex == 1
        //               ? AppColors.primaryColor
        //               : AppColors.blackColor,
        //         ),
        //       ),
        //       label: 'My wardrobe',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
