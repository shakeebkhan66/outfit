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

class ColorStyleWidget extends StatefulWidget {
  final ColorsAndStylesViewModel colorsViewModel;
  const ColorStyleWidget({Key? key, required this.colorsViewModel}) : super(key: key);

  @override
  State<ColorStyleWidget> createState() => _ColorStyleWidgetState();
}

class _ColorStyleWidgetState extends State<ColorStyleWidget> {
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
  final _selectedGradientColors = <Map<String, List<dynamic>>?>[null];

  final _isColorExpanded = [false];
  final _isStyleExpanded = [false];

  void _selectGradientColors(int i, String color, List<dynamic> colors) {
    _selectedGradientColors[i] = {};
    _selectedGradientColors[i]![color] = colors;
    _isColorExpanded[i] = !_isColorExpanded[i];
    setState(() {});
  }

  final _searchStyle = <Data?>[null];

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final filterPairProvider = Provider.of<FilterPairProvider>(context);
    return Column(
      children: [
        for (int i = 0; i < _isColorExpanded.length; i++)
        Container(
          key: UniqueKey(),
          decoration: _boxDecoration,
          margin: const EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: 18,
          ),
          padding: _isColorExpanded.length <= 1
              ? const EdgeInsets.all(4)
              : EdgeInsets.zero,
          child: Row(
            children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 20, 9.28, 20),
                child: ChangeNotifierProvider<ColorsAndStylesViewModel>.value(
                  value:  widget.colorsViewModel,
                  child: Consumer<ColorsAndStylesViewModel>(
                    builder: (context, value, child) {
                      switch (value.colorsList.status!) {
                        case Status.completed:
                        late Data data = value.colorsList.data!.typesModel.data!.first;
                        return Column(
                          children: [
                          Row(children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _isColorExpanded[i] = !_isColorExpanded[i];
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: _dropDownDecoration,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 14,
                                  ),
                                  margin: !(_isColorExpanded.length <= 1)
                                      ? const EdgeInsets.only(right: 9.28)
                                      : EdgeInsets.zero,
                                  child: Row(children: [
                                    const Icon(
                                      Icons.color_lens,
                                      color: AppColors.primaryColor,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: _selectedGradientColors[i] == null
                                            ? Text(AppLocalization.of(context)!.getTranslatedValues("choosenearestcolor")!,
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : Row(children: [
                                                Expanded(
                                                  child: Text(
                                                    _selectedGradientColors[i]!.keys.first,
                                                    maxLines: 1,
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child:
                                                  getGradientContainer(
                                                      _selectedGradientColors[i]!
                                                          .values.first,
                                                      false),
                                                ),
                                              ]),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xFF9F9F9F),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            if (!(_isColorExpanded.length <= 1)) ...[
                              GestureDetector(
                                onTap: () {
                                  _isColorExpanded.removeAt(i);
                                  _isStyleExpanded.removeAt(i);
                                  _selectedGradientColors.removeAt(i);
                                  _searchStyle.removeAt(i);
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
                          ]),
                          Visibility(
                            visible: _isColorExpanded[i],
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: _menuDecoration,
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: value.colorsList.data!.colorsModel.data!.map((colors) => GestureDetector(
                                    onTap: () {
                                      print(filterPairProvider.getSearchColor);
                                      filterPairProvider.setSearchColor(i,colors.cid!);
                                      filterPairProvider.setPattern(i,colors.patterned!);
                                      if(colors.pattern == ""){
                                        _selectGradientColors(i, 
                                          currentLanguage.languageCode=="en"? 
                                              colors.name_en!:
                                              colors.name!,
                                          [
                                            hexToColor(colors.hex!),
                                            hexToColor(colors.hex!).withOpacity(0.1),
                                          ]);
                                      }else{
                                        _selectGradientColors(i, 
                                          currentLanguage.languageCode=="en"? 
                                              colors.name_en!:
                                              colors.name!,
                                          [
                                            colors.pattern,
                                          ]);
                                      }
                                        
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _getTitle(currentLanguage.languageCode=="en"? 
                                          colors.name_en!:
                                          colors.name!
                                        ),
                                        colors.pattern!!="" ?
                                        getImageContainer(colors.pattern!):
                                        getGradientContainer(
                                          [
                                            hexToColor(colors.hex!),
                                            hexToColor(colors.hex!).withOpacity(0.1),
                                          ],
                                        ),
                                        _getDivider(),
                                      ],
                                    ),
                                  ),).toList(),
                              ),
                            ),
                          ),
                          Row(children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _isStyleExpanded[i] = !_isStyleExpanded[i];
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: _dropDownDecoration,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 14,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 13,
                                    right: !(_isColorExpanded.length <= 1) ? 30 : 0,
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
                                            _searchStyle[i] == null
                                                ? AppLocalization.of(context)!.getTranslatedValues("choosestyle")!
                                                : _searchStyle[i]!.en_name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xFF9F9F9F),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          Visibility(
                            visible: _isStyleExpanded[i],
                            child: Container(
                              decoration: _menuDecoration,
                              margin: const EdgeInsets.only(top: 16),
                              child: SearchStyleRadioWidget<Data>(
                                groupController: RadioWidgetController<Data>(
                                  items: value.colorsList.data!.typesModel.data!,
                                  value: _searchStyle[i],
                                  onChanged: (_) {
                                    filterPairProvider.setType(i, _.tid!);
                                    _searchStyle[i] = _;
                                    data = _;
                                    _isStyleExpanded[i] = !_isStyleExpanded[i];
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          )
                        ]);
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
          ]),
        ),
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
                  _isColorExpanded.add(false);
                  _isStyleExpanded.add(false);
                    _selectedGradientColors.add(null);
                  _searchStyle.add(null);
                  filterPairProvider.addNullAtEnd();
                  setState(() {});
                },
              ),
            ),
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
      padding: const EdgeInsets.only(left: 34, top: 10),
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
Widget getGradientContainer(
    List<dynamic> colors,
    [
      bool hasPadding = true, 
      double width = double.infinity, 
      bool isCircle=false
    ]
    ) {
    List<Color> listColor = colors.whereType<Color>().toList();
    return Container(
      width: width,
      height: isCircle ? 13 : 13,
      margin: isCircle ? const EdgeInsets.only(right: 5.0, bottom: 7.0) : hasPadding
          ? const EdgeInsets.symmetric(horizontal: 34, vertical: 8)
          : const EdgeInsets.symmetric(vertical: 8),
      decoration: colors.length < 2 ? null : 
      BoxDecoration(
        borderRadius: isCircle ? null : BorderRadius.circular(3),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        gradient: LinearGradient(colors: listColor),
      ),
      child: colors.length < 2 ? Image.network("https://stylorita.com/admin/${colors.first}",
        fit: BoxFit.cover,
      ) : Container(),
    );
  }
  Widget getImageContainer(
    String pattern,
    [
      bool hasPadding = true, 
      double width = double.infinity, 
      bool isCircle=false
    ]
    ) {
    return Container(
      width: width,
      height: isCircle ? 13 : 13,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      margin: isCircle ? const EdgeInsets.only(right: 5.0 , bottom: 7.0) : hasPadding
          ? const EdgeInsets.symmetric(horizontal: 34, vertical: 8)
          : const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isCircle ? 12.5 : 0.0),
        child: Image.network("https://stylorita.com/admin/$pattern",
          fit: BoxFit.cover,
        ),
      ),
    );
  }