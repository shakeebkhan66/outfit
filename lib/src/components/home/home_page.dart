import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/home/views/outfit_ideas_view.dart';
import 'package:outfit/src/components/home/views/wardrobe_view.dart';
import 'package:outfit/src/components/save_wardrobe/save_wardrobe_page.dart';
import 'package:outfit/src/components/search/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageIndex = 0;
  late List<Map<String, Widget>> _pages;

  void _selectPage(int index) {
    _pageIndex = index;
    if (_pageIndex == 0) {
      _pages = [
        {'page': const OutfitIdeasView()},
        {
          'page': WardrobeView(
            onSaveTap: () {
              _pages = [
                {'page': const OutfitIdeasView()},
                {'page': const SaveWardrobePage()},
              ];
              setState(() {});
            },
          ),
        },
      ];
    }
    setState(() {});
  }

  @override
  void initState() {
    _pages = [
      {'page': const OutfitIdeasView()},
      {
        'page': WardrobeView(
          onSaveTap: () {
            _pages = [
              {'page': const OutfitIdeasView()},
              {'page': const SaveWardrobePage()},
            ];
            setState(() {});
          },
        ),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    Widget? floatingActionButton;
    if (!(keyboardIsOpened || _pageIndex != 0)) {
      floatingActionButton = Transform.scale(
        scale: 1.2,
        child: FloatingActionButton(
          key: UniqueKey(),
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.search),
          onPressed: () {
            AppNavigation.to(context, const SearchPage());
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
      body: _pages[_pageIndex]['page'],
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
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    _selectPage(0);
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      AppAssets.outfitIdeas,
                      width: 24,
                      height: 26,
                      color: _pageIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(height: 4),
                    Text(AppLocalization.of(context)!
                        .getTranslatedValues('outfitideas')!,
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        color: _pageIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
                    _selectPage(1);
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(
                      AppAssets.wardrobe,
                      width: 16.33,
                      height: 23.56,
                      color: _pageIndex == 1
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(height: 4),
                    Text(AppLocalization.of(context)!
                        .getTranslatedValues('mywardrobe')!,
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        color: _pageIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
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
