import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/widgets/video_player_controller.dart';
import 'package:provider/provider.dart';

class WardrobePageTitleWidget extends StatelessWidget {
  final GlobalKey wardrobeGuideKey;
  const WardrobePageTitleWidget({Key? key, required this.wardrobeGuideKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 30, right: 29),
      title: RichText(
        text: TextSpan(
          text: AppLocalization.of(context)!.getTranslatedValues("my"),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: AppLocalization.of(context)!.getTranslatedValues("wardrobe"),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        AppLocalization.of(context)!.getTranslatedValues("letushelpyoudress")!,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      trailing: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialog();
            },
          );
        },
        child: Container(
          key: wardrobeGuideKey,
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            color: Color(0xFFE096C6),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '?',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int selectedIndex = 0;
  final List<String> title = [
    "wardrobeTitle1",
    "wardrobeTitle2",
    "wardrobeTitle3",
  ];
  final List<String> subTitle = [
    "wardrobeSubtitle1",
    "wardrobeSubtitle2",
    "wardrobeSubtitle3",
  ];
  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.only(left: 14.0, right: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
                  child: Text(
                    AppLocalization.of(context)!.getTranslatedValues(title.elementAt(selectedIndex))!,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: height > 640.0 ? 18.0 : 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                selectedIndex == 2
                    ? VideoPlayerScreen(
                        url: currentLanguage.languageCode == "ar" ? AppAssets.tutorialVideo : AppAssets.tutorialen,
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalization.of(context)!.getTranslatedValues(subTitle.elementAt(selectedIndex))!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height > 640.0 ? 16.0 : 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 32.0),
                  child: selectedIndex == 0
                      ? FilledNextButton(
                          onNextPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          title: "Next",
                        )
                      : selectedIndex == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BackBorderButton(
                                  onBackPressed: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                  },
                                ),
                                FilledNextButton(
                                  onNextPressed: () {
                                    setState(() {
                                      selectedIndex = 2;
                                    });
                                  },
                                  title: "Next",
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BackBorderButton(
                                  onBackPressed: () {
                                    setState(() {
                                      selectedIndex = 1;
                                    });
                                  },
                                ),
                                FilledNextButton(
                                  onNextPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: "Start",
                                ),
                              ],
                            ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE096C6),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackBorderButton extends StatelessWidget {
  final VoidCallback onBackPressed;
  const BackBorderButton({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onBackPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(120, 42)),
        maximumSize: MaterialStateProperty.all<Size>(const Size(120, 42)),
      ),
      child: const Text(
        'Back',
        style: TextStyle(color: AppColors.primaryColor),
      ),
    );
  }
}

class FilledNextButton extends StatelessWidget {
  final String title;
  final VoidCallback onNextPressed;
  const FilledNextButton({super.key, required this.onNextPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onNextPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(120, 42)),
        maximumSize: MaterialStateProperty.all<Size>(const Size(120, 42)),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
