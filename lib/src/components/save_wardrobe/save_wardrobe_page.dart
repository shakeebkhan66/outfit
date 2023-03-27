import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/widgets/container_title_widget.dart';
import 'package:outfit/src/widgets/wardrobe_page_title_widget.dart';

class SaveWardrobePage extends StatefulWidget {
  const SaveWardrobePage({Key? key}) : super(key: key);

  @override
  State<SaveWardrobePage> createState() => _SaveWardrobePageState();
}

class _SaveWardrobePageState extends State<SaveWardrobePage> {
  final _colors = [
    const Color(0xFF6D6C6D),
    const Color(0xFFFFC24B),
    AppColors.primaryColor,
    const Color(0xFFFF725E),
    const Color(0xFF00A861),
    const Color(0xFF7000F4),
    const Color(0xFF006565),
    const Color(0xFFF7DA24),
  ];
  late final _wardRobe = <SaveWardrobeModel>[
    SaveWardrobeModel(
      title: 'Trousers',
      icon: AppAssets.trouserIcon,
      width: 21,
      height: 34,
      dividerMargin: const EdgeInsets.only(left: 17, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Shirt',
      icon: AppAssets.shirtIcon,
      width: 34,
      height: 35,
      dividerMargin: const EdgeInsets.only(left: 10, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Tops (sweater-blouse-shirt)',
      icon: AppAssets.topsIcon,
      width: 31,
      height: 36,
      dividerMargin: const EdgeInsets.only(left: 11, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Skirt',
      icon: AppAssets.skirtIcon,
      width: 37,
      height: 36,
      dividerMargin: const EdgeInsets.only(left: 8, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Dress-Jumpsuit-Abaya',
      icon: AppAssets.dressJumpsuitAbayaIcon,
      width: 32,
      height: 41,
      dividerMargin: const EdgeInsets.only(left: 10, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Jacket-coat',
      icon: AppAssets.jacketCoatIcon,
      width: 37,
      height: 40,
      dividerMargin: const EdgeInsets.only(left: 8, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Blazer',
      icon: AppAssets.blazerIcon,
      width: 30.73,
      height: 47,
      dividerMargin: const EdgeInsets.only(left: 14.27, right: 19),
      colors: _colors,
    ),
    SaveWardrobeModel(
      title: 'Cardigon-Kimono-Bolero',
      icon: AppAssets.cardigonKimonoBoleroIcon,
      width: 37.77,
      height: 40,
      dividerMargin: const EdgeInsets.only(left: 11.23, right: 19),
      colors: _colors,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Container(
        margin: EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
        ),
        color: AppColors.primaryColor,
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          const WardrobePageTitleWidget(),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ContainerTitleWidget(),
                    const SizedBox(height: 24),
                    for (final item in _wardRobe) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: AppShadow.primaryShadow,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 17,
                          left: 28,
                          right: 28,
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          21,
                          14,
                          25.48,
                          14,
                        ),
                        child: Row(children: [
                          Image.asset(
                            item.icon,
                            height: item.height,
                            width: item.width,
                          ),
                          Container(
                            width: 1,
                            margin: item.dividerMargin,
                            height: 58,
                            color: const Color(0xFFECEBEB),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
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
                                    item.noOfItems,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color(0xFF888787),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: item.colors.map((e) {
                                    return Container(
                                      height: 13,
                                      width: 13,
                                      margin: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: e,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ]),
                      )
                    ],
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class SaveWardrobeModel {
  final String title;
  final String icon;
  final String noOfItems;
  final List<Color> colors;
  final double width;
  final double height;
  final EdgeInsets dividerMargin;

  SaveWardrobeModel({
    required this.title,
    required this.icon,
    required this.colors,
    this.noOfItems = '8 Items',
    required this.dividerMargin,
    required this.width,
    required this.height,
  });
}
