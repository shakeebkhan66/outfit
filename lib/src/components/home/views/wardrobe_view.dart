

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/wardrobe_view_model.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/container_title_widget.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:outfit/src/widgets/wardrobe_page_title_widget.dart';
import 'package:provider/provider.dart';

class WardrobeView extends StatefulWidget {
  const WardrobeView({Key? key, required this.onSaveTap}) : super(key: key);

  final VoidCallback onSaveTap;

  @override
  State<WardrobeView> createState() => _WardrobeViewState();
}

class _WardrobeViewState extends State<WardrobeView> {
  final WardrobeViewModel wardrobeViewModel = WardrobeViewModel();
  @override
  void initState() {
    super.initState();
    wardrobeViewModel.fetchWardrobeList();
  }

  ListTileControlAffinity get _controlAffinity =>
      ListTileControlAffinity.leading;

  VisualDensity get visualDensity => const VisualDensity(
        vertical: -4,
        horizontal: -4,
      );

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
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
          ChangeNotifierProvider.value(
            value: wardrobeViewModel,
            child: Consumer<WardrobeViewModel>(
              builder: (context, value, child) {
                switch (value.colorsList.status!) {
                  case Status.loading:
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: const WardrobeColorShimmerLoader()),
                    ),
                  );
                  case Status.error:
                  return const Text("error");
                  case Status.completed:
                  return Expanded(
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
                            for (final item in wardrobeViewModel.wardRobe) ...[
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title,
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
                                                  child: Text("${wardrobeViewModel.getSelectedColors[item.id]!.length} items",
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
                                                    return wardrobeViewModel.getSelectedColors[item.id]!
                                                            .contains(colors.cid.toString()) ? colors.pattern!!="" ?
                                                        getImageContainer(colors.pattern!,false,13.0,true):
                                                        getGradientContainer(
                                                          [
                                                            hexToColor(colors.hex!),
                                                            hexToColor(colors.hex!).withOpacity(0.1),
                                                          ],
                                                            false,
                                                            13.0,true,
                                                        ): Container(
                                                          width: 0,
                                                          height: 0,
                                                          padding: EdgeInsets.zero,
                                                        );
                                                  }).toList(),
                                                ),
                                              ],
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
                                        child: Column(
                                          children: [
                                            Wrap(
                                              children: value.colorsList.data!.colorsModel.data!.asMap().map((index, colors){
                                                return MapEntry(index, 
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width/2-28,
                                                      child: CheckboxListTile(
                                                      activeColor: AppColors.primaryColor,
                                                      controlAffinity: _controlAffinity,
                                                      visualDensity: visualDensity,
                                                      dense: true,
                                                      value:  wardrobeViewModel.getSelectedColors[item.id]!
                                                      .contains(colors.cid.toString()), 
                                                      onChanged: (_){
                                                        if (wardrobeViewModel.getSelectedColors[item.id]!
                                                            .contains(colors.cid.toString())) {
                                                          wardrobeViewModel.getSelectedColors[item.id]!
                                                              .remove(colors.cid.toString());
                                                        } else {
                                                          wardrobeViewModel.getSelectedColors[item.id]!
                                                              .add(colors.cid!.toString());
                                                        }
                                                        setState(() {});                                           
                                                      },
                                                      title: _getTitle(
                                                        currentLanguage.languageCode=="en"? 
                                                        colors.name_en!:
                                                        colors.name!,
                                                      ),
                                                      subtitle: colors.pattern!!="" ?
                                                      getImageContainer(colors.pattern!,false):
                                                      getGradientContainer(
                                                        [
                                                          hexToColor(colors.hex!),
                                                          hexToColor(colors.hex!).withOpacity(0.1),
                                                        ],
                                                          false,
                                                      ),
                                                     ),
                                                    ),
                                                  );
                                              }).values.toList(),
                                            ),
                                          const SizedBox(height: 20),
                                          wardrobeViewModel.loading ? 
                                          const CustomLoader() :
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 21,
                                            ),
                                            child: AppButtonWidget(
                                              onTap: () {
                                                if(wardrobeViewModel.getwardrobeIds[item.id]!.isNotEmpty){
                                                  wardrobeViewModel.updateWardrobeApi({
                                                    "user_id": "2794263897328614",
                                                    "type": item.id,
                                                    "colors": wardrobeViewModel.getSelectedColors[item.id]!,
                                                  },wardrobeViewModel.getwardrobeIds[item.id]!, context);
                                                }else {
                                                  wardrobeViewModel.addWardrobeApi({
                                                    "user_id": "2794263897328614",
                                                    "type": item.id,
                                                    "colors": wardrobeViewModel.getSelectedColors[item.id]!,
                                                  }, context);
                                                }
                                              },
                                              buttonSize: const Size.fromHeight(50),
                                              // onTap: widget.onSaveTap,
                                              title: 'save',
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
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: AppButtonWidget(
                                onTap: (){}, title: "continue",
                              ),
                            ),
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
