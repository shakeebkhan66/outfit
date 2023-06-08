import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/favorite_detail/favorite_detail_page.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/wardrobe_view_model.dart';
import 'package:outfit/src/providers/add_helper.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:outfit/src/utils/tutorial_guide.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/container_title_widget.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:outfit/src/widgets/refresh_widget.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:outfit/src/widgets/wardrobe_page_title_widget.dart';
import 'package:provider/provider.dart';

class WardrobeView extends StatefulWidget {
  const WardrobeView({Key? key}) : super(key: key);
  @override
  State<WardrobeView> createState() => _WardrobeViewState();
}

class _WardrobeViewState extends State<WardrobeView> {
  final WardrobeViewModel wardrobeViewModel = WardrobeViewModel();
  final ScrollController _scrollController = ScrollController();
  final String userId = AuthLocalDataSource.getUserid();
  final bool isShowwardrobeTutorial = AuthLocalDataSource.getTutorial6();
  final GlobalKey wardrobeGuideKey = GlobalKey();
  InterstitialAd? interstitialAd;
  void _loadInterstitialAd({required VoidCallback onCrossPressed}) {
    InterstitialAd.load(
      adUnitId: AdHelper.searchAndWardrobeAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              onCrossPressed();
            },
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
    _scrollController.addListener(_scrollListener);
    wardrobeViewModel.fetchWardrobeList(
      userid: userId,
    );
    TutorialGuide tutorialGuide = TutorialGuide(
      wardrobeViewGuideKey: wardrobeGuideKey,
    );
    tutorialGuide.createWardrobeTutorial(onFinished: () {
      AuthLocalDataSource.setTutorial6();
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext contextz) {
            return const CustomDialog();
          },
        );
      });
    });
    if (!isShowwardrobeTutorial) {
      Future.delayed(Duration.zero, tutorialGuide.showWardrobeTutorial(context));
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent - 1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  ListTileControlAffinity get _controlAffinity => ListTileControlAffinity.leading;

  VisualDensity get visualDensity => const VisualDensity(
        vertical: -4,
        horizontal: -4,
      );
  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final padding = MediaQuery.of(context).padding;
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.only(top: 30),
      margin: EdgeInsets.only(
        top: padding.top,
        bottom: padding.bottom,
      ),
      child: Column(children: [
        WardrobePageTitleWidget(
          wardrobeGuideKey: wardrobeGuideKey,
        ),
        const SizedBox(height: 25),
        ChangeNotifierProvider.value(
          value: wardrobeViewModel,
          child: Consumer<WardrobeViewModel>(
            builder: (context, value, child) {
              switch (value.colorsList.status!) {
                case Status.loading:
                  return Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          child: const WardrobeColorShimmerLoader()),
                    ),
                  );
                case Status.error:
                  return Expanded(
                    child: RefreshWidget(
                      error: value.colorsList.message.toString(),
                      onRefresh: () {
                        wardrobeViewModel.fetchWardrobeList(
                          userid: userId,
                        );
                      },
                    ),
                  );
                case Status.completed:
                  List<String> combinedList =
                      wardrobeViewModel.getSelectedColors.values.fold<List<String>>([], (prevList, nextList) => prevList..addAll(nextList));
                  return Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(top: 38),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ContainerTitleWidget(),
                            const SizedBox(height: 19),
                            for (int i = 0; i < wardrobeViewModel.wardRobe.length; i++) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 28,
                                  right: 28,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        wardrobeViewModel.wardRobe[i].isExpanded = !wardrobeViewModel.wardRobe[i].isExpanded;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: wardrobeViewModel.wardRobe[i].isExpanded ? const Color(0xFfFBE7F3) : Colors.white,
                                          borderRadius: BorderRadius.circular(11),
                                          boxShadow: AppShadow.primaryShadow,
                                        ),
                                        margin: const EdgeInsets.only(bottom: 13),
                                        padding: const EdgeInsets.fromLTRB(
                                          21,
                                          11,
                                          25.48,
                                          11,
                                        ),
                                        child: Row(children: [
                                          Image.asset(
                                            wardrobeViewModel.wardRobe[i].icon,
                                            width: wardrobeViewModel.wardRobe[i].width,
                                            height: wardrobeViewModel.wardRobe[i].height,
                                          ),
                                          Container(
                                            height: 41,
                                            width: 1,
                                            color: wardrobeViewModel.wardRobe[i].isExpanded ? const Color(0xFFD7D6D6) : const Color(0xFFECEBEB),
                                            margin: wardrobeViewModel.wardRobe[i].dividerMargin,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  currentLanguage.languageCode == "en"
                                                      ? wardrobeViewModel.wardRobe[i].title
                                                      : wardrobeViewModel.wardRobe[i].arabicTitle,
                                                  maxLines: 1,
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 4,
                                                  ),
                                                  child: Text(
                                                    "${wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!.length} items",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                      color: const Color(0xFF888787),
                                                    ),
                                                  ),
                                                ),
                                                Wrap(
                                                  children: value.colorsList.data!.colorsModel.data!.map((colors) {
                                                    return wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!
                                                            .contains(colors.cid.toString())
                                                        ? colors.pattern! != ""
                                                            ? getImageContainer(colors.pattern!, false, 13.0, true)
                                                            : getGradientContainer(
                                                                [
                                                                  hexToColor(colors.hex!),
                                                                  colors.hex == "#000000"
                                                                      ? hexToColor(colors.hex!)
                                                                      : hexToColor(colors.hex!).withOpacity(0.1),
                                                                ],
                                                                false,
                                                                13.0,
                                                                true,
                                                              )
                                                        : Container(
                                                            width: 0,
                                                            height: 0,
                                                            padding: EdgeInsets.zero,
                                                          );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          wardrobeViewModel.wardRobe[i].isExpanded
                                              ? const Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 25.0,
                                                  color: Color(0xFF9F9F9F),
                                                )
                                              : const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 25.0,
                                                  color: Color(0xFF9F9F9F),
                                                ),
                                        ]),
                                      ),
                                    ),
                                    Visibility(
                                      visible: wardrobeViewModel.wardRobe[i].isExpanded,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9F9F9),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        margin: const EdgeInsets.only(bottom: 15),
                                        child: Column(
                                          children: [
                                            Wrap(
                                              children: value.colorsList.data!.colorsModel.data!
                                                  .asMap()
                                                  .map((index, colors) {
                                                    return MapEntry(
                                                      index,
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width / 2 - 28,
                                                        child: CheckboxListTile(
                                                          activeColor: AppColors.primaryColor,
                                                          controlAffinity: _controlAffinity,
                                                          visualDensity: visualDensity,
                                                          dense: true,
                                                          value: wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!
                                                              .contains(colors.cid.toString()),
                                                          onChanged: (_) {
                                                            if (wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!
                                                                .contains(colors.cid.toString())) {
                                                              wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!
                                                                  .remove(colors.cid.toString());
                                                              wardrobeViewModel.getSelectedColorsForDelete[wardrobeViewModel.wardRobe[i].id]!
                                                                  .add(colors.cid!.toString());
                                                            } else {
                                                              wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!
                                                                  .add(colors.cid!.toString());
                                                            }
                                                            setState(() {});
                                                          },
                                                          title: _getTitle(
                                                            currentLanguage.languageCode == "en" ? colors.name_en! : colors.name!,
                                                          ),
                                                          subtitle: colors.pattern! != ""
                                                              ? getImageContainer(colors.pattern!, false)
                                                              : getGradientContainer(
                                                                  [
                                                                    hexToColor(colors.hex!),
                                                                    colors.hex == "#000000"
                                                                        ? hexToColor(colors.hex!)
                                                                        : hexToColor(colors.hex!).withOpacity(0.1),
                                                                  ],
                                                                  false,
                                                                ),
                                                        ),
                                                      ),
                                                    );
                                                  })
                                                  .values
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 20),
                                            wardrobeViewModel.loading
                                                ? const CustomLoader()
                                                : Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 21,
                                                    ),
                                                    child: AppButtonWidget(
                                                      onTap: () {
                                                        final position = _scrollController.position;
                                                        _scrollController.animateTo(
                                                          position.pixels / (i > 4 ? 4 : 8), // Replace with the position you want to scroll to
                                                          duration: const Duration(milliseconds: 500),
                                                          curve: Curves.easeInOut,
                                                        );
                                                        setState(() {
                                                          wardrobeViewModel.wardRobe[i].isExpanded = !wardrobeViewModel.wardRobe[i].isExpanded;
                                                        });
                                                        if (wardrobeViewModel.getwardrobeIds[wardrobeViewModel.wardRobe[i].id]!.isNotEmpty) {
                                                          wardrobeViewModel.updateWardrobeApi(
                                                            {
                                                              "user_id": userId,
                                                              "type": wardrobeViewModel.wardRobe[i].id,
                                                              "colors": wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!,
                                                            },
                                                            wardrobeViewModel.getwardrobeIds[wardrobeViewModel.wardRobe[i].id]!,
                                                            wardrobeViewModel.wardRobe[i].id,
                                                            context,
                                                          );
                                                        } else {
                                                          wardrobeViewModel.addWardrobeApi(
                                                            {
                                                              "user_id": userId,
                                                              "type": wardrobeViewModel.wardRobe[i].id,
                                                              "colors": wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!,
                                                            },
                                                            context,
                                                          );
                                                        }
                                                      },
                                                      buttonSize: const Size.fromHeight(50),
                                                      // onTap: widget.onSaveTap,
                                                      title: 'save',
                                                      titleSize: 18,
                                                    ),
                                                  ),
                                            wardrobeViewModel.getwardrobeIds[wardrobeViewModel.wardRobe[i].id]!.isNotEmpty
                                                ? Align(
                                                    alignment: Alignment.centerRight,
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return DeleteWardrobeDialog(
                                                              onDelete: () {
                                                                wardrobeViewModel.getSelectedColors[wardrobeViewModel.wardRobe[i].id]!.clear();
                                                                wardrobeViewModel.deleteWardrobe(
                                                                  wardrobeId: int.parse(
                                                                    wardrobeViewModel.getwardrobeIds[wardrobeViewModel.wardRobe[i].id]!,
                                                                  ),
                                                                  userId: userId,
                                                                  context: context,
                                                                );
                                                                wardrobeViewModel.UpdateTypeIds(wardrobeViewModel.wardRobe[i].id);
                                                                final position = _scrollController.position;
                                                                _scrollController.animateTo(
                                                                  position.pixels /
                                                                      (i > 4 ? 4 : 8), // Replace with the position you want to scroll to
                                                                  duration: const Duration(milliseconds: 500),
                                                                  curve: Curves.easeInOut,
                                                                );
                                                                wardrobeViewModel.wardRobe[i].isExpanded = !wardrobeViewModel.wardRobe[i].isExpanded;
                                                                setState(() {});
                                                                Navigator.of(context).pop();
                                                              },
                                                            );
                                                          },
                                                          barrierDismissible: false,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "clear all",
                                                        style: TextStyle(
                                                          color: AppColors.primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                            if (combinedList.isEmpty)
                              Container()
                            else
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 28.0, bottom: 10.0),
                                child: AppButtonWidget(
                                  onTap: () {
                                    _loadInterstitialAd(onCrossPressed: () {});
                                    AppNavigation.to(
                                      context,
                                      FavoriteDetailPage(
                                        page: "wardrobe",
                                        favFoldersViewModel: FavFoldersViewModel(),
                                        folderName: AppLocalization.of(context)!.getTranslatedValues("mywardrobe")!,
                                        wardrobeViewModel: wardrobeViewModel,
                                        gettingFavFolder: FavFoldersViewModel(),
                                      ),
                                    );
                                  },
                                  title: "dressme",
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget _getTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: const Color(0xFF898686),
      ),
    );
  }
}

class DeleteWardrobeDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteWardrobeDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                AppLocalization.of(context)!.getTranslatedValues("wardrobeDelete")!,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF319D97,
                      ).withOpacity(0.7126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalization.of(context)!.getTranslatedValues("close")!,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEE3E38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    onPressed: onDelete,
                    child: Text(
                      AppLocalization.of(context)!.getTranslatedValues("delete")!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
