import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/search/search_page.dart';
import 'package:outfit/src/widgets/radio_button_widget.dart';

class ColorStyleWidget extends StatefulWidget {
  const ColorStyleWidget({Key? key}) : super(key: key);

  @override
  State<ColorStyleWidget> createState() => _ColorStyleWidgetState();
}

class _ColorStyleWidgetState extends State<ColorStyleWidget> {
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

  final _blackGradient = [Colors.black, Colors.black];
  final _whiteGradient = [
    Colors.white,
    const Color(0xFFB8C1A4).withOpacity(0.25),
  ];
  final _darkBlueGradient = [
    const Color(0xFF121150),
    const Color(0xFF201CBB).withOpacity(0.7126),
    const Color(0xFF211DC5).withOpacity(0.6867),
    const Color(0xFF0E0C89).withOpacity(0.25),
  ];
  final _blueGradient = [
    const Color(0xFF1E1AEF),
    const Color(0xFF2420E3).withOpacity(0.7126),
    const Color(0xFF211DC5).withOpacity(0.6867),
    const Color(0xFF6B68FF).withOpacity(0.5),
  ];
  final _tealGradient = [
    const Color(0xFF137059),
    const Color(0xFF1A6D4F).withOpacity(0.6867),
    const Color(0xFF47C0B9).withOpacity(0.7126),
    const Color(0xFF47AD7C).withOpacity(0.25),
  ];
  final _greyGradient = [
    const Color(0xFFB2B0B0),
    const Color(0xFFA0A19E).withOpacity(0.1),
  ];
  final _selectedGradientColors = <Map<String, List<Color>>?>[null];

  final _isColorExpanded = [false];
  final _isStyleExpanded = [false];

  void _selectGradientColors(int i, String color, List<Color> colors) {
    _selectedGradientColors[i] = {};
    _selectedGradientColors[i]![color] = colors;
    _isColorExpanded[i] = !_isColorExpanded[i];
    setState(() {});
  }

  final _searchStyle = <SearchStyle?>[null];

  @override
  Widget build(BuildContext context) {
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
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 20, 9.28, 20),
                  child: Column(children: [
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
                                      ? Text(
                                          'Choose nearest color',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : Row(children: [
                                          Expanded(
                                            child: Text(
                                              _selectedGradientColors[i]!
                                                  .keys
                                                  .first,
                                              maxLines: 1,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: _getGradientContainer(
                                                _selectedGradientColors[i]!
                                                    .values
                                                    .first,
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
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(
                                    i, 'Black', _blackGradient);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('Black'),
                                  _getGradientContainer(_blackGradient),
                                  _getDivider(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(
                                    i, 'White', _whiteGradient);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('White/Off white'),
                                  _getGradientContainer(_whiteGradient),
                                  _getDivider(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(i, 'Grey', _greyGradient);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('Grey'),
                                  _getGradientContainer(_greyGradient),
                                  _getDivider(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(
                                  i,
                                  'Dark blue',
                                  _darkBlueGradient,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('Dark blue/Navy blue'),
                                  _getGradientContainer(_darkBlueGradient),
                                  _getDivider(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(i, 'Blue', _blueGradient);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('Blue'),
                                  _getGradientContainer(_blueGradient),
                                  _getDivider(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectGradientColors(i, 'Teal', _tealGradient);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle('Teal'),
                                  _getGradientContainer(_tealGradient),
                                ],
                              ),
                            ),
                          ],
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
                                          ? 'Choose style'
                                          : _searchStyle[i]!.value,
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
                        child: SearchStyleRadioWidget<SearchStyle>(
                          groupController: RadioWidgetController<SearchStyle>(
                            items: SearchStyle.values,
                            value: _searchStyle[i],
                            onChanged: (_) {
                              _searchStyle[i] = _;
                              _isStyleExpanded[i] = !_isStyleExpanded[i];
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
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

  Widget _getGradientContainer(List<Color> colors, [bool hasPadding = true]) {
    return Container(
      width: double.infinity,
      height: 13,
      margin: hasPadding
          ? const EdgeInsets.symmetric(horizontal: 34, vertical: 8)
          : const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}
