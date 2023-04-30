import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/data/model/types_model.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:outfit/src/widgets/radio_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ColorStyleWidget extends StatefulWidget {
  final ColorsAndStylesViewModel colorsViewModel;
  const ColorStyleWidget({Key? key, required this.colorsViewModel}) : super(key: key);

  @override
  State<ColorStyleWidget> createState() => _ColorStyleWidgetState();
}

class _ColorStyleWidgetState extends State<ColorStyleWidget> {
  final ItemScrollController _scrollController = ItemScrollController();
  @override
  void initState() {
    widget.colorsViewModel.fetchColorsList();
    super.initState();
  }

  Decoration get _boxDecoration {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: AppShadow.primaryShadow,
      borderRadius: BorderRadius.circular(15),
    );
  }

  Decoration get _dropDownDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      border: Border.all(
        color: AppColors.primaryColor,
        width: 1.5,
      ),
    );
  }

  Decoration get _menuDecoration {
    return BoxDecoration(
      color: const Color(0xFFF9F9F9),
      borderRadius: BorderRadius.circular(12),
    );
  }

  // final _isColorExpanded = [false];
  // final  widget.colorsViewModel.isStyleExpanded = [false];

  // void  widget.colorsViewModel.selectGradientColors(int i, String color, List<dynamic> colors) {
  //    widget.colorsViewModel.selectGradientColors[i] = {};
  //    widget.colorsViewModel.selectGradientColors[i]![color] = colors;
  //   _isColorExpanded[i] = !_isColorExpanded[i];
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final colorsViewModelProvider = Provider.of<ColorsAndStylesViewModel>(context);
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final filterPairProvider = Provider.of<FilterPairProvider>(context);
    return Column(
      children: [
        Expanded(
          child: ScrollablePositionedList.builder(
            padding: const EdgeInsets.only(bottom: 120, top: 20.0),
            itemCount: colorsViewModelProvider.getIsColorExpanded.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    key: UniqueKey(),
                    decoration: _boxDecoration,
                    margin: const EdgeInsets.only(
                      left: 28,
                      right: 28,
                      bottom: 18,
                    ),
                    padding: colorsViewModelProvider.getIsColorExpanded.length <= 1 ? const EdgeInsets.all(4) : EdgeInsets.zero,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(13, 20, 9.28, 20),
                            child: ChangeNotifierProvider<ColorsAndStylesViewModel>.value(
                              value: widget.colorsViewModel,
                              child: Consumer<ColorsAndStylesViewModel>(
                                builder: (context, value, child) {
                                  switch (value.colorsList.status!) {
                                    case Status.completed:
                                      late Data data = value.colorsList.data!.typesModel.data!.first;
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (colorsViewModelProvider.isStyleExpanded[index] == true) {
                                                      colorsViewModelProvider.updateIsStyleExpanded(index);
                                                    }
                                                    colorsViewModelProvider.updateIsColorExpanded(index);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: _dropDownDecoration,
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 14,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      right: currentLanguage.languageCode == "en" &&
                                                              !(colorsViewModelProvider.getIsColorExpanded.length <= 1)
                                                          ? 9.28
                                                          : 0.0,
                                                      left: currentLanguage.languageCode == "ar" &&
                                                              !(colorsViewModelProvider.getIsColorExpanded.length <= 1)
                                                          ? 9.28
                                                          : 0.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.color_lens,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                            ),
                                                            child: colorsViewModelProvider.getSelectedGradientColors[index] == null
                                                                ? Text(
                                                                    AppLocalization.of(context)!.getTranslatedValues("choosenearestcolor")!,
                                                                    style: GoogleFonts.montserrat(
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  )
                                                                : Row(children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        colorsViewModelProvider.getSelectedGradientColors[index]!.keys.first,
                                                                        maxLines: 1,
                                                                        style: GoogleFonts.montserrat(
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: getGradientContainer(
                                                                          colorsViewModelProvider.getSelectedGradientColors[index]!.values.first,
                                                                          false),
                                                                    ),
                                                                  ]),
                                                          ),
                                                        ),
                                                        Icon(
                                                          colorsViewModelProvider.getIsColorExpanded[index]
                                                              ? Icons.keyboard_arrow_up
                                                              : Icons.keyboard_arrow_down,
                                                          color: const Color(0xFF9F9F9F),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (!(colorsViewModelProvider.getIsColorExpanded.length <= 1)) ...[
                                                GestureDetector(
                                                  onTap: () {
                                                    //  colorsViewModelProvider.removeIsColorExpanded(i);
                                                    colorsViewModelProvider.removeIsColorExpanded(index);
                                                    colorsViewModelProvider.removeIsSelectedGradientColor(index);
                                                    colorsViewModelProvider.removeSearchStyle(index);
                                                    filterPairProvider.removeNullAtEnd(index);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    height: 18.44,
                                                    width: 18.44,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFFF725E),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          Visibility(
                                            visible: colorsViewModelProvider.getIsColorExpanded[index],
                                            child: Container(
                                              decoration: _menuDecoration,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: value.colorsList.data!.colorsModel.data!
                                                    .map(
                                                      (colors) => GestureDetector(
                                                        onTap: () {
                                                          filterPairProvider.setSearchColor(index, colors.cid!);
                                                          filterPairProvider.setPattern(index, colors.patterned!);
                                                          if (colors.pattern == "") {
                                                            colorsViewModelProvider.selectGradientColors(
                                                                index, currentLanguage.languageCode == "en" ? colors.name_en! : colors.name!, [
                                                              hexToColor(colors.hex!),
                                                              hexToColor(colors.hex!).withOpacity(0.1),
                                                            ]);
                                                          } else {
                                                            colorsViewModelProvider.selectGradientColors(
                                                              index,
                                                              currentLanguage.languageCode == "en" ? colors.name_en! : colors.name!,
                                                              [
                                                                colors.pattern!,
                                                              ],
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          color: Colors.transparent,
                                                          padding: const EdgeInsets.only(bottom: 4),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              _getTitle(currentLanguage.languageCode == "en" ? colors.name_en! : colors.name!),
                                                              colors.pattern! != ""
                                                                  ? getImageContainer(colors.pattern!)
                                                                  : getGradientContainer(
                                                                      [
                                                                        hexToColor(colors.hex!),
                                                                        hexToColor(colors.hex!).withOpacity(0.1),
                                                                      ],
                                                                    ),
                                                              _getDivider(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (colorsViewModelProvider.isColorExpanded[index] == true) {
                                                      colorsViewModelProvider.updateIsColorExpanded(index);
                                                    }
                                                    colorsViewModelProvider.updateIsStyleExpanded(index);
                                                  },
                                                  child: Container(
                                                    decoration: _dropDownDecoration,
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 14,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      top: 13,
                                                      right: currentLanguage.languageCode == "en" &&
                                                              !(colorsViewModelProvider.getIsColorExpanded.length <= 1)
                                                          ? 28
                                                          : 0.0,
                                                      left: currentLanguage.languageCode == "en" ||
                                                              (colorsViewModelProvider.getIsColorExpanded.length <= 1)
                                                          ? 0.0
                                                          : 28.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.apps,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                            ),
                                                            child: Text(
                                                              colorsViewModelProvider.getSearchStyle[index] == null
                                                                  ? AppLocalization.of(context)!.getTranslatedValues("choosestyle")!
                                                                  : currentLanguage.languageCode == "en"
                                                                      ? colorsViewModelProvider.getSearchStyle[index]!.en_name!
                                                                      : colorsViewModelProvider.getSearchStyle[index]!.name!,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.clip,
                                                              style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          colorsViewModelProvider.getIsStyleExpanded[index]
                                                              ? Icons.keyboard_arrow_up
                                                              : Icons.keyboard_arrow_down,
                                                          color: const Color(0xFF9F9F9F),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: colorsViewModelProvider.getIsStyleExpanded[index],
                                            child: Container(
                                              decoration: _menuDecoration,
                                              margin: const EdgeInsets.only(top: 16),
                                              child: SearchStyleRadioWidget<Data>(
                                                groupController: RadioWidgetController<Data>(
                                                  items: value.colorsList.data!.typesModel.data!,
                                                  value: colorsViewModelProvider.getSearchStyle[index],
                                                  onChanged: (_) {
                                                    filterPairProvider.setType(index, _.tid!);
                                                    colorsViewModelProvider.updateSearchStyle(index, _);
                                                    data = _;
                                                    colorsViewModelProvider.updateIsStyleExpanded(index);
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    case Status.loading:
                                      return const CustomLoader();
                                    case Status.error:
                                      return Text(value.colorsList.message!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index == colorsViewModelProvider.getIsColorExpanded.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 28),
                        child: Transform.scale(
                          scale: 0.85,
                          child: FloatingActionButton(
                            backgroundColor: AppColors.primaryColor,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              colorsViewModelProvider.setIsColorExpanded(false);
                              colorsViewModelProvider.setIsStyleExpanded(false);
                              colorsViewModelProvider.setIsSelectedGradientColor(null);
                              colorsViewModelProvider.setSearchStyle(null);
                              filterPairProvider.addNullAtEnd();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getDivider() {
    return const Divider(color: Color(0xFFE1DFDF), thickness: 1, height: 0);
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 34, top: 10, right: 34),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: const Color(0xFF727070),
        ),
      ),
    );
  }
}

Widget getGradientContainer(List<dynamic> colors, [bool hasPadding = true, double width = double.infinity, bool isCircle = false]) {
  List<Color> listColor = colors.whereType<Color>().toList();
  return Container(
    width: width,
    height: isCircle ? 13 : 13,
    margin: isCircle
        ? const EdgeInsets.only(right: 5.0, bottom: 7.0)
        : hasPadding
            ? const EdgeInsets.symmetric(horizontal: 34, vertical: 8)
            : const EdgeInsets.symmetric(vertical: 8),
    decoration: colors.length < 2
        ? null
        : BoxDecoration(
            borderRadius: isCircle ? null : BorderRadius.circular(3),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(colors: listColor),
          ),
    child: colors.length < 2
        ? Image.network(
            "https://stylorita.com/admin/${colors.first}",
            fit: BoxFit.cover,
          )
        : Container(),
  );
}

Widget getImageContainer(String pattern, [bool hasPadding = true, double width = double.infinity, bool isCircle = false]) {
  return Container(
    width: width,
    height: isCircle ? 13 : 13,
    decoration: BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    ),
    margin: isCircle
        ? const EdgeInsets.only(right: 5.0, bottom: 7.0)
        : hasPadding
            ? const EdgeInsets.symmetric(horizontal: 34, vertical: 8)
            : const EdgeInsets.symmetric(vertical: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(isCircle ? 12.5 : 0.0),
      child: Image.network(
        "https://stylorita.com/admin/$pattern",
        fit: BoxFit.cover,
      ),
    ),
  );
}
