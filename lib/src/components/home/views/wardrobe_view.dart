import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/container_title_widget.dart';
import 'package:outfit/src/widgets/wardrobe_page_title_widget.dart';

class WardrobeView extends StatefulWidget {
  const WardrobeView({Key? key, required this.onSaveTap}) : super(key: key);

  final VoidCallback onSaveTap;

  @override
  State<WardrobeView> createState() => _WardrobeViewState();
}

class _WardrobeViewState extends State<WardrobeView> {
  final _wardRobe = <DataModel>[
    DataModel(
      title: 'Trousers',
      icon: AppAssets.trouserIcon,
      width: 17,
      height: 28,
      dividerMargin: const EdgeInsets.only(left: 22, right: 19),
    ),
    DataModel(
      title: 'Shirt',
      icon: AppAssets.shirtIcon,
      width: 24,
      height: 22,
      dividerMargin: const EdgeInsets.only(left: 15, right: 19),
    ),
    DataModel(
      title: 'Tops (sweater-blouse-shirt)',
      icon: AppAssets.topsIcon,
      width: 24,
      height: 24,
      dividerMargin: const EdgeInsets.only(left: 15, right: 19),
    ),
    DataModel(
      title: 'Skirt',
      icon: AppAssets.skirtIcon,
      width: 25,
      height: 22,
      dividerMargin: const EdgeInsets.only(left: 14, right: 19),
    ),
    DataModel(
      title: 'Dress-Jumpsuit-Abaya',
      icon: AppAssets.dressJumpsuitAbayaIcon,
      width: 20,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 19, right: 19),
    ),
    DataModel(
      title: 'Jacket-coat',
      icon: AppAssets.jacketCoatIcon,
      width: 23,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 16, right: 19),
    ),
    DataModel(
      title: 'Blazer',
      icon: AppAssets.blazerIcon,
      width: 17,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 22, right: 19),
    ),
    DataModel(
      title: 'Cardigon-Kimono-Bolero',
      icon: AppAssets.cardigonKimonoBoleroIcon,
      width: 22.67,
      height: 24,
      dividerMargin: const EdgeInsets.only(left: 16.33, right: 19),
    ),
  ];

  late final _selectedColors = <String, List<ListColors>>{
    for (int i = 0; i < _wardRobe.length; i++) _wardRobe[i].title: [],
  };

  ListTileControlAffinity get _controlAffinity =>
      ListTileControlAffinity.leading;

  VisualDensity get visualDensity => const VisualDensity(
        vertical: -4,
        horizontal: -4,
      );

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.only(top: 30),
        margin: EdgeInsets.only(
          top: padding.top,
          bottom: padding.bottom,
        ),
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
                    const SizedBox(height: 19),
                    for (final item in _wardRobe) ...[
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
                                item.isExpanded = !item.isExpanded;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: item.isExpanded
                                      ? const Color(0xFfFBE7F3)
                                      : Colors.white,
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
                                    item.icon,
                                    width: item.width,
                                    height: item.height,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 1,
                                    color: item.isExpanded
                                        ? const Color(0xFFD7D6D6)
                                        : const Color(0xFFECEBEB),
                                    margin: item.dividerMargin,
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      maxLines: 1,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF9F9F9F),
                                    size: 15,
                                  )
                                ]),
                              ),
                            ),
                            Visibility(
                              visible: item.isExpanded,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 32,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Column(children: [
                                  /// First
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.black),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.black)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.black);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.black);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [Colors.black, Colors.black],
                                      ),
                                      title: _getTitle(
                                        ListColors.black.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.orange),
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.orange)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.orange);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.orange);
                                        }
                                        setState(() {});
                                      },
                                      dense: true,
                                      visualDensity: visualDensity,
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFFF0A20B),
                                          const Color(0xFFF0A20B).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.orange.value,
                                      ),
                                    ),
                                  ]),

                                  /// Second
                                  _getDivider(),
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.white),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.white)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.white);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.white);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          Colors.white,
                                          const Color(0xFFB8C1A4).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.white.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.brown),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.brown)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.brown);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.brown);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF7D341D),
                                          const Color(0xFF981E03).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.brown.value,
                                      ),
                                    ),
                                  ]),

                                  /// Third
                                  _getDivider(),
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.grey),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.grey)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.grey);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.grey);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFFB2B0B0),
                                          const Color(0xFFA0A19E).withOpacity(
                                            0.1,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.grey.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.greyTwo),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.greyTwo)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.greyTwo);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.greyTwo);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFFB2B0B0),
                                          const Color(0xFFA0A19E).withOpacity(
                                            0.1,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.greyTwo.value,
                                      ),
                                    ),
                                  ]),

                                  /// Fourth
                                  _getDivider(),
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.darkBlue),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.darkBlue)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.darkBlue);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.darkBlue);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF121150),
                                          const Color(0xFF201CBB).withOpacity(
                                            0.7126,
                                          ),
                                          const Color(0xFF211DC5).withOpacity(
                                            0.6867,
                                          ),
                                          const Color(0xFF0E0C89).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.darkBlue.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.darkBlueTwo),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.darkBlueTwo)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.darkBlueTwo);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.darkBlueTwo);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF121150),
                                          const Color(0xFF201CBB).withOpacity(
                                            0.7126,
                                          ),
                                          const Color(0xFF211DC5).withOpacity(
                                            0.6867,
                                          ),
                                          const Color(0xFF0E0C89).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.darkBlueTwo.value,
                                      ),
                                    ),
                                  ]),

                                  /// Fifth
                                  _getDivider(),
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.blue),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.blue)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.blue);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.blue);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF1E1AEF),
                                          const Color(0xFF2420E3).withOpacity(
                                            0.7126,
                                          ),
                                          const Color(0xFF211DC5).withOpacity(
                                            0.6867,
                                          ),
                                          const Color(0xFF6B68FF).withOpacity(
                                            0.5,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.blue.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.green),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.green)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.green);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.green);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF0FA063),
                                          const Color(0xFF119D30).withOpacity(
                                            0.7126,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.green.value,
                                      ),
                                    ),
                                  ]),

                                  /// Sixth
                                  _getDivider(),
                                  _getRow([
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.teal),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.teal)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.teal);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.teal);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFF137059),
                                          const Color(0xFF1A6D4F).withOpacity(
                                            0.6867,
                                          ),
                                          const Color(0xFF47C0B9).withOpacity(
                                            0.7126,
                                          ),
                                          const Color(0xFF47AD7C).withOpacity(
                                            0.25,
                                          ),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.teal.value,
                                      ),
                                    ),
                                    CheckboxListTile(
                                      controlAffinity: _controlAffinity,
                                      activeColor: AppColors.primaryColor,
                                      value: _selectedColors[item.title]!
                                          .contains(ListColors.yellow),
                                      dense: true,
                                      visualDensity: visualDensity,
                                      onChanged: (_) {
                                        if (_selectedColors[item.title]!
                                            .contains(ListColors.yellow)) {
                                          _selectedColors[item.title]!
                                              .remove(ListColors.yellow);
                                        } else {
                                          _selectedColors[item.title]!
                                              .add(ListColors.yellow);
                                        }
                                        setState(() {});
                                      },
                                      subtitle: _getSubtitleContainer(
                                        [
                                          const Color(0xFFF4C406),
                                          const Color(0xFFF4C406),
                                        ],
                                      ),
                                      title: _getTitle(
                                        ListColors.yellow.value,
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 21,
                                    ),
                                    child: AppButtonWidget(
                                      // onTap: () {
                                      //   AppNavigation.to(
                                      //     context,
                                      //     const SaveWardrobePage(),
                                      //   );
                                      // },
                                      buttonSize: const Size.fromHeight(50),
                                      onTap: widget.onSaveTap,
                                      title: 'Save',
                                      titleSize: 18,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _getRow(List<Widget> children) {
    return Row(children: [
      Expanded(child: children.first),
      Expanded(child: children.last),
    ]);
  }

  Widget _getTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: const Color(0xFF898686),
      ),
    );
  }

  Widget _getSubtitleContainer(List<Color> colors) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, bottom: 6),
      height: 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }

  Widget _getDivider() {
    return const Divider(color: Color(0xFFE1DFDF), height: 0, thickness: 1);
  }
}

class DataModel {
  final String title;
  final String icon;
  final double height;
  final double width;
  final EdgeInsets dividerMargin;
  bool isExpanded;

  DataModel({
    required this.title,
    required this.icon,
    required this.width,
    required this.height,
    required this.dividerMargin,
    this.isExpanded = false,
  });
}

enum ListColors {
  black('Black'),
  orange('Orange'),
  white('White/Off White'),
  brown('Brown'),
  grey('Grey'),
  greyTwo('Grey'),
  darkBlue('Dark blue'),
  darkBlueTwo('Dark blue'),
  blue('Blue'),
  green('Green'),
  teal('Teal'),
  yellow('Yellow'),
  ;

  final String value;

  const ListColors(this.value);
}
