import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final ProductsViewModel productsViewModel;
  final VoidCallback callback;
  const SearchPage({Key? key, required this.productsViewModel, required this.callback}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ColorsAndStylesViewModel colorsViewModel = ColorsAndStylesViewModel();
  final productsViewModel = ProductsViewModel();
  final String email = AuthLocalDataSource.getEmail();
  GlobalKey searchButtonGuideKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final colorsViewModelProvider = Provider.of<ColorsAndStylesViewModel>(context);
    final page = Provider.of<ProductsViewModel>(context);
    final filterPairProvider = Provider.of<FilterPairProvider>(context);
    final padding = MediaQuery.of(context).padding;
    searchPressed() {
      for (var i = 0; i < filterPairProvider.getSearchColor.length; i++) {
        if (filterPairProvider.getSearchColor[i] == null) {
          return AppUtils.flushBarErrorMessage("Please select color", context);
        } else if (filterPairProvider.getSearchColor[i] == null && filterPairProvider.getSearchType[i] != null) {
          return AppUtils.flushBarErrorMessage("Please select color", context);
        } else if (filterPairProvider.getSearchColor[i] != null && filterPairProvider.getSearchType[i] == null) {
          return AppUtils.flushBarErrorMessage("Please select type", context);
        } else if (filterPairProvider.getSearchType[i] == null) {
          return AppUtils.flushBarErrorMessage("Please select type", context);
        }
      }
      widget.productsViewModel.setImagesData();
      page.setPage("search");
      page.setSetIndex(0);
      widget.callback.call();
      AppNavigation.pop(context);
      widget.productsViewModel.setCurrentPage(Pages.search);
      widget.productsViewModel
          .fetchFilterPairList(
        context: context,
        email: email,
        FilterPairModel(
          pairs: [
            for (var i = 0; i < filterPairProvider.getSearchColor.length; i++)
              Pairs(
                type: filterPairProvider.getSearchType[i],
                color: filterPairProvider.getSearchColor[i],
              ),
          ],
          ptn: filterPairProvider.getSearchPattern[0],
        ),
      )
          .then((value) {
        // filterPairProvider.clearaddNullAtEnd();
      });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 17),
            child: Row(children: [
              _containerWidget(
                Text(
                  '?',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    AppLocalization.of(context)!.getTranslatedValues("letushelpyoudress")!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => AppNavigation.pop(context),
                child: _containerWidget(
                  const Icon(Icons.close, color: Colors.white, size: 17),
                ),
              ),
            ]),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                for (var i = 0; i < colorsViewModelProvider.isColorExpanded.length; i++) {
                  if (colorsViewModelProvider.isColorExpanded[i] == true) {
                    colorsViewModelProvider.updateIsColorExpanded(i);
                  }
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ColorStyleWidget(
                  searchButtonGuideKey: searchButtonGuideKey,
                  target3Pressed: () {
                    searchPressed();
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomSheet: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, bottom: 32),
          child: AppButtonWidget(
            key: searchButtonGuideKey,
            onTap: () async {
              searchPressed();
            },
            title: 'search',
          ),
        ),
      ),
    );
  }

  Widget _containerWidget(Widget child) {
    return Container(
      height: 25,
      width: 25,
      decoration: const BoxDecoration(
        color: Color(0xFFE096C6),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
