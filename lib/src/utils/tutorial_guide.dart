import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialGuide {
  static late TutorialCoachMark searchtutorialCoachMark;
  static late TutorialCoachMark addSearchtutorialCoachMark;
  static late TutorialCoachMark outfittutorialCoachMark;
  static late TutorialCoachMark wardrobetutorialCoachMark;
  GlobalKey? searchGuideKey = GlobalKey();
  GlobalKey? addGuideKey = GlobalKey();
  GlobalKey? searchButtonGuideKey = GlobalKey();
  GlobalKey? outfitViewGuideKey = GlobalKey();
  GlobalKey? wardrobeViewGuideKey = GlobalKey();
  TutorialGuide({
    this.searchGuideKey,
    this.addGuideKey,
    this.searchButtonGuideKey,
    this.outfitViewGuideKey,
    this.wardrobeViewGuideKey,
  });
  showSearchTutorial(context) {
    searchtutorialCoachMark.show(context: context);
  }

  showAddSearchTutorial(context) {
    addSearchtutorialCoachMark.show(context: context);
  }

  showoutfitTutorial(context) {
    outfittutorialCoachMark.show(context: context);
  }

  showWardrobeTutorial(context) {
    wardrobetutorialCoachMark.show(context: context);
  }

  finishAddSearchTutorial() {
    addSearchtutorialCoachMark.finish();
  }

  void createSearchTutorial({FutureOr<void> Function(TargetFocus)? onClickTarget}) {
    searchtutorialCoachMark = TutorialCoachMark(
      targets: _createSearchTarget(),
      colorShadow: Colors.red,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        AuthLocalDataSource.setTutorial1();
      },
      onClickTarget: onClickTarget,
      onSkip: () {
        print("skip");
      },
    );
  }

  void createoutfitTutorial(context) {
    outfittutorialCoachMark = TutorialCoachMark(
      targets: _createOutfitTarget(context),
      colorShadow: Colors.red,
      hideSkip: true,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () async {
        await AuthLocalDataSource.setTutorial4();
      },
      onClickTarget: (target) {
        AuthLocalDataSource.setTutorial4();
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  void createAddSearchTutorial({required FutureOr<void> Function(TargetFocus)? onClickTarget}) {
    addSearchtutorialCoachMark = TutorialCoachMark(
      targets: _createAddSearchTarget(),
      colorShadow: Colors.red,
      hideSkip: true,
      paddingFocus: 5.0,
      opacityShadow: 0.8,
      onFinish: () {
        AuthLocalDataSource.setTutorial3();
      },
      onClickTarget: onClickTarget,
      onSkip: () {
        print("skip");
      },
    );
  }

  void createWardrobeTutorial({required VoidCallback onFinished}) {
    wardrobetutorialCoachMark = TutorialCoachMark(
      targets: _createWardrobeTarget(),
      colorShadow: Colors.red,
      hideSkip: true,
      paddingFocus: 5.0,
      opacityShadow: 0.8,
      onFinish: onFinished,
      onClickTarget: (target) {},
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createSearchTarget() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: searchGuideKey,
        color: Colors.grey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return TutorialCard(
                tutorialCoachMark: searchtutorialCoachMark,
                title: "explaination1",
              );
            },
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 20,
      ),
    );
    return targets;
  }

  List<TargetFocus> _createOutfitTarget(context) {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: outfitViewGuideKey,
        color: Colors.grey,
        contents: [
          TargetContent(
            customPosition: CustomTargetContentPosition(
              top: MediaQuery.of(context).padding.top - 15,
            ),
            align: ContentAlign.custom,
            builder: (context, controller) {
              return TutorialCard(
                tutorialCoachMark: outfittutorialCoachMark,
                title: "explaination4",
                subtitle: "explaination5",
                isOutfitPage: true,
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );
    return targets;
  }

  List<TargetFocus> _createWardrobeTarget() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Target 5",
        keyTarget: wardrobeViewGuideKey,
        color: Colors.grey,
        contents: [
          TargetContent(
            customPosition: CustomTargetContentPosition(
              top: 10.0,
            ),
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return TutorialCard(
                tutorialCoachMark: wardrobetutorialCoachMark,
                isWardrobeScreen: true,
                title: "explaination6",
              );
            },
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 10,
      ),
    );
    return targets;
  }

  List<TargetFocus> _createAddSearchTarget() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: addGuideKey,
        color: Colors.grey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return TutorialCard(
                tutorialCoachMark: addSearchtutorialCoachMark,
                title: "explaination2",
                isNext: true,
                isAddTarget: true,
              );
            },
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: searchButtonGuideKey,
        color: Colors.grey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return TutorialCard(
                tutorialCoachMark: addSearchtutorialCoachMark,
                title: "explaination3",
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );
    return targets;
  }
}

class TutorialCard extends StatelessWidget {
  final TutorialCoachMark tutorialCoachMark;
  final bool isNext;
  final bool isAddTarget;
  final bool isWardrobeScreen;
  final bool isOutfitPage;
  final String title;
  final String subtitle;
  const TutorialCard({
    super.key,
    required this.tutorialCoachMark,
    this.isNext = false,
    this.isWardrobeScreen = false,
    this.isOutfitPage = false,
    this.isAddTarget = false,
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    return Column(
      children: [
        isWardrobeScreen
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Align(
                  alignment: currentLanguage.languageCode == "ar" ? Alignment.centerLeft : Alignment.centerRight,
                  child: CustomPaint(
                    painter: TopArrowPainter(),
                    child: const SizedBox(
                      height: 20.0,
                      width: 30.0,
                    ),
                  ),
                ),
              )
            : Container(),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.of(context)!.getTranslatedValues(title)!,
                  style: const TextStyle(color: Colors.black),
                ),
                isOutfitPage
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          AppLocalization.of(context)!.getTranslatedValues(subtitle)!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: currentLanguage.languageCode == "ar" ? Alignment.centerLeft : Alignment.centerRight,
                  child: SizedBox(
                    width: 80.0,
                    height: 40.0,
                    child: AppButtonWidget(
                      onTap: () {
                        if (isNext) {
                          tutorialCoachMark.next();
                        } else {
                          if (isOutfitPage) {
                            AuthLocalDataSource.setTutorial4();
                          }
                          tutorialCoachMark.finish();
                        }
                      },
                      buttonRadius: 4.0,
                      title: isNext ? "next" : "ok",
                      titleSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isWardrobeScreen
            ? Container()
            : Align(
                alignment: isAddTarget ? Alignment.centerRight : Alignment.center,
                child: Padding(
                  padding: isAddTarget ? const EdgeInsets.only(right: 14.0) : EdgeInsets.zero,
                  child: CustomPaint(
                    painter: ArrowPainter(),
                    child: const SizedBox(
                      height: 20.0,
                      width: 30.0,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TopArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
