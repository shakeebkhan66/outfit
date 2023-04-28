import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/components/favorites/favorites_folders_page.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/components/home/widget/drawer_widget.dart';
import 'package:outfit/src/components/search/search_page.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/custom_webview_drawer.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class OutfitIdeasView extends StatefulWidget {
  final ProductsViewModel productViewModel;
  const OutfitIdeasView({Key? key, required this.productViewModel}) : super(key: key);

  @override
  State<OutfitIdeasView> createState() => _OutfitIdeasViewState();
}

class _OutfitIdeasViewState extends State<OutfitIdeasView> {
  final colorandstyleViewModel = ColorsAndStylesViewModel();
  final _scrollController = ScrollController();
  final String email = AuthLocalDataSource.getEmail();
  final String ip = AuthLocalDataSource.getIp();
  bool filterDrawer = true;
  @override
  void initState() {
    widget.productViewModel.fetchPhotosList(
      context: context,
      email: email,
      ip: ip,
    );
    super.initState();
  }

  final _searchFocusNode = FocusNode();
  final _searchController = TextEditingController();
  var season = Seasons.allSeasons;
  var hijab = Hijab.all;
  var style = Styles.allStyle;

  OutlineInputBorder get _inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: Color(0x00000000)),
      );

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final String email = AuthLocalDataSource.getEmail();
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final filterPairProvider = Provider.of<FilterPairProvider>(context);
    final productViewProvider = Provider.of<ProductsViewModel>(context);
    final colorsViewModelProvider = Provider.of<ColorsAndStylesViewModel>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      endDrawer: filterDrawer
          ? DrawerWidget(
              hijab: hijab,
              style: style,
              season: season,
              callback: (newStyle, newHijab, newSeason) {
                hijab = newHijab;
                season = newSeason;
                style = newStyle;
              },
              productsViewModel: widget.productViewModel,
            )
          : const WebDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if (email == "") {
              AppNavigation.to(context, const SocialAuthPage());
            } else {
              AppNavigation.to(context, const FavoritesFolderPage());
            }
          },
          child: const Icon(
            Icons.bookmark_border,
            color: AppColors.blackColor,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                filterDrawer = false;
              });
              scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.blackColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 27.8, 16, 10.0),
            sliver: SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  AppNavigation.to(
                      context,
                      SearchPage(
                        productsViewModel: widget.productViewModel,
                      ));
                },
                child: TextFormField(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                    hintText: AppLocalization.of(context)!.getTranslatedValues("searchfordresses"),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: _inputBorder,
                    enabled: false,
                    enabledBorder: _inputBorder,
                    focusedBorder: _inputBorder,
                    filled: true,
                    fillColor: const Color(0xFFFFF6F8),
                    suffixIcon: const Icon(Icons.search, color: Color(0xFF8C8C8C)),
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF8C8C8C),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: colorsViewModelProvider.selectedGradientColors[0] == null ? 10.0 : 10.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context)!.getTranslatedValues("trendydress")!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  if (productViewProvider.getPageName == "search")
                    InkWell(
                      onTap: () {
                        colorsViewModelProvider.clearStyleAndColorSearch();
                        widget.productViewModel.setCurrentPage(Pages.products);
                        productViewProvider.setPage('outfit');
                        widget.productViewModel.fetchPhotosList(email: email, ip: ip, context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6F8),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              size: 15.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              AppLocalization.of(context)!.getTranslatedValues("back")!,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          filterDrawer = true;
                        });
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6F8),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Image.asset(
                            AppAssets.filter,
                            width: 12,
                            height: 12,
                          ),
                          const SizedBox(width: 7.22),
                          Text(
                            AppLocalization.of(context)!.getTranslatedValues("filter")!,
                            style: const TextStyle(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ]),
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (colorsViewModelProvider.selectedGradientColors[0] == null)
            const SliverToBoxAdapter()
          else
            SliverPadding(
              padding: const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 10.0, top: 5.0),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  runSpacing: 8,
                  spacing: 10,
                  alignment: WrapAlignment.start,
                  children: colorsViewModelProvider.selectedGradientColors
                      .asMap()
                      .map((index, stylecolor) => MapEntry(
                          index,
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBF9),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  color: Colors.black.withOpacity(0.075),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 6,
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              if (stylecolor != null)
                                Wrap(
                                  children: stylecolor
                                      .map((key, value) => MapEntry(
                                            key,
                                            Wrap(
                                              children: [
                                                if (value.first is Color)
                                                  circleContainer(value)
                                                else
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.network(
                                                      "https://stylorita.com/admin/${value.first}",
                                                      width: 38.0,
                                                      height: 18.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ))
                                      .values
                                      .toList(),
                                ),
                              // Image.asset(e.icon, width: 38, height: 20),
                              const SizedBox(width: 4),
                              if (colorsViewModelProvider.getSearchStyle[index] != null)
                                Text(
                                  currentLanguage.languageCode == "en"
                                      ? colorsViewModelProvider.getSearchStyle[index]!.en_name!
                                      : colorsViewModelProvider.getSearchStyle[index]!.name!,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                            ]),
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
          ChangeNotifierProvider.value(
            value: widget.productViewModel,
            child: Consumer<ProductsViewModel>(
              builder: (context, value, child) {
                switch (value.productsList.status!) {
                  case Status.completed:
                    return SliverPadding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 30.0,
                        top: 8,
                      ),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (_, i) {
                            List<ProductsData> products = value.productsList.data!.data!.data!;
                            return GestureDetector(
                              onTap: () {
                                AppNavigation.to(
                                  context,
                                  DressDetailPage(
                                    productViewModel: widget.productViewModel,
                                    isFavourite: widget.productViewModel.getFavouriteList.contains(i) ? true : false,
                                    dress: AppUrl.webUrl + products[i].url!,
                                    source: products[i].source!,
                                    imageId: products[i].uid.toString(),
                                    index: i,
                                    id: products[i].uid!,
                                    page: "outfit",
                                  ),
                                ).then((value) {
                                  // favList.clear();
                                  if (productViewProvider.getPageName == "search") {
                                    widget.productViewModel.fetchFilterPairList(
                                      context: context,
                                      email: email,
                                      ip: ip,
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
                                    );
                                  } else if (productViewProvider.getPageName == "filter") {
                                    widget.productViewModel.filterPhotoPhotosList(
                                      context: context,
                                      email: email,
                                      ip: ip,
                                    );
                                  } else {
                                    widget.productViewModel.fetchPhotosList(
                                      context: context,
                                      email: email,
                                      ip: ip,
                                    );
                                  }
                                });
                              },
                              child: GridTile(
                                footer: GridTileBar(
                                  leading: GestureDetector(
                                    onTap: () => AppUtils.share(products[i].uid!, currentLanguage.languageCode),
                                    child: const Icon(
                                      Icons.share,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  title: const Text(""),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      if (widget.productViewModel.favouriteList.contains(i)) {
                                        widget.productViewModel.removeFromFavourite(i);
                                        widget.productViewModel.decrementFromFavourite(i);
                                        widget.productViewModel.unLikeImageById(email: email, ip: ip, id: products[i].uid!.toString());
                                      } else {
                                        widget.productViewModel.addFromFavourite(i);
                                        widget.productViewModel.incrementFromFavourite(i);
                                        widget.productViewModel.likeImageById(email: email, ip: ip, id: products[i].uid!.toString());
                                      }
                                    },
                                    child: Icon(
                                      widget.productViewModel.favouriteList.contains(i) ? Icons.favorite : Icons.favorite_border,
                                      color: widget.productViewModel.favouriteList.contains(i) ? const Color(0xFFFF2C2C) : AppColors.blackColor,
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(AppUrl.webUrl + products[i].url!, fit: BoxFit.fill)),
                              ),
                            );
                          },
                          childCount: value.productsList.data!.data!.data!.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 226,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 16,
                        ),
                      ),
                    );
                  case Status.error:
                    return SliverToBoxAdapter(child: Center(child: Text(value.productsList.message.toString())));
                  case Status.loading:
                    return const CustomShimmerLoader(
                      itemCount: 10,
                    );
                }
              },
            ),
          ),
          ChangeNotifierProvider.value(
            value: widget.productViewModel,
            child: Consumer<ProductsViewModel>(
              builder: (context, value, child) {
                switch (value.productsList.status!) {
                  case Status.completed:
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12.0,
                          bottom: 108,
                        ),
                        child: Pagination(
                          onTapFWD: () => value.increaseTotalPages(),
                          onTapBWD: () => value.decreaseTotalPages(),
                          numOfPages: value.getTotalPages,
                          selectedPage: value.getPage,
                          pagesVisible: 13,
                          onPageChanged: (index) {
                            value.setNoPage(index);
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            if (value.getCurrentPage == Pages.products) {
                              productViewProvider.setPage("outfit");
                              value.fetchPhotosList(
                                context: context,
                                email: email,
                                ip: ip,
                              );
                            } else if (value.getCurrentPage == Pages.filter) {
                              productViewProvider.setPage("filter");
                              value.filterPhotoPhotosList(
                                context: context,
                                email: email,
                                ip: ip,
                              );
                            } else if (value.getCurrentPage == Pages.search) {
                              productViewProvider.setPage("search");
                              value.fetchFilterPairList(
                                context: context,
                                email: email,
                                ip: ip,
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
                              );
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  case Status.error:
                    return SliverToBoxAdapter(child: Container());
                  case Status.loading:
                    return SliverToBoxAdapter(child: Container());
                }
              },
            ),
          ),
          // ChangeNotifierProvider.value(
          //   value: widget.productViewModel,
          //   child: Consumer<ProductsViewModel>(
          //     builder: (context, value, child) {
          //       return SliverPadding(
          //         padding: const EdgeInsets.only(
          //           left: 16,
          //           right: 16,
          //           bottom: 108,
          //           top: 8,
          //         ),
          //         sliver: SliverToBoxAdapter(
          //           child: value.productsList.status == Status.error ?
          //           AppButtonWidget(
          //             onTap: (){
          //               widget.productViewModel.fetchPhotosList(
          //                 email: email,
          //                 ip: ip,
          //               );
          //             },
          //             title: "refresh",
          //           ):
          //           Row(
          //             children: [
          //               if(value.page == 1)
          //               Container()
          //               else
          //               Expanded(
          //                 child: AppButtonWidget(
          //                   onTap: (){
          //                     // favList.clear();
          //                     _scrollController.animateTo(
          //                       0,
          //                       duration: const Duration(milliseconds: 500),
          //                       curve: Curves.easeInOut,
          //                     );
          //                     if(widget.productViewModel.getCurrentPage == Pages.products){
          //                       widget.productViewModel.setPage("outfit");
          //                       widget.productViewModel.fetchPhotosList(
          //                         email: email,
          //                         ip: ip,
          //                       );
          //                     }else if(widget.productViewModel.getCurrentPage == Pages.filter){
          //                       widget.productViewModel.setPage("filter");
          //                       widget.productViewModel.filterPhotoPhotosList(
          //                         email: email,
          //                         ip: ip,
          //                       );
          //                     }else if(widget.productViewModel.getCurrentPage == Pages.search){
          //                       widget.productViewModel.setPage("search");
          //                       widget.productViewModel.fetchFilterPairList(
          //                         email: email,
          //                         ip: ip,
          //                         FilterPairModel(
          //                           pairs: [
          //                             for (var i = 0; i < filterPairProvider.getSearchColor.length; i++)
          //                             Pairs(
          //                               type: filterPairProvider.getSearchType[i],
          //                               color: filterPairProvider.getSearchColor[i],
          //                             ),
          //                           ],
          //                           ptn: filterPairProvider.getSearchPattern[0],
          //                         ),
          //                       );
          //                     }
          //                   },
          //                   title: "previouspage",
          //                   buttonRadius: 5.0,
          //                   titleSize: 16.0,
          //                   buttonSize: const Size.fromHeight(20.0),
          //                 ),
          //               ),
          //               if(widget.productViewModel.getPage == widget.productViewModel.getTotalPages)
          //               Container()
          //               else
          //               ...[SizedBox(width: widget.productViewModel.getPage == 1 ? 0.0 : 10.0,),
          //               Expanded(
          //                 child: AppButtonWidget(
          //                   onTap: (){
          //                     // favList.clear();
          //                     _scrollController.animateTo(
          //                       0,
          //                       duration: const Duration(milliseconds: 500),
          //                       curve: Curves.easeInOut,
          //                     );
          //                     if(widget.productViewModel.getCurrentPage == Pages.products){
          //                       widget.productViewModel.setPage("outfit");
          //                       widget.productViewModel.fetchPhotosList(
          //                         email: email,
          //                         ip: ip,
          //                       );
          //                     }else if(widget.productViewModel.getCurrentPage == Pages.filter){
          //                       widget.productViewModel.setPage("filter");
          //                       widget.productViewModel.filterPhotoPhotosList(
          //                         email: email,
          //                         ip: ip,
          //                       );
          //                     }else if(widget.productViewModel.getCurrentPage == Pages.search){
          //                       widget.productViewModel.setPage("search");
          //                       widget.productViewModel.fetchFilterPairList(
          //                         email: email,
          //                         ip: ip,
          //                         FilterPairModel(
          //                           pairs: [
          //                             for (var i = 0; i < filterPairProvider.getSearchColor.length; i++)
          //                             Pairs(
          //                               type: filterPairProvider.getSearchType[i],
          //                               color: filterPairProvider.getSearchColor[i],
          //                             ),
          //                           ],
          //                           ptn: filterPairProvider.getSearchPattern[0],
          //                         ),
          //                       );
          //                     }
          //                   },
          //                   title: "nextpage",
          //                   titleSize: 18.0,
          //                   buttonRadius: 5.0,
          //                   buttonSize: const Size.fromHeight(20.0),
          //                 ),
          //               ),]
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

enum Styles {
  allStyle('allstyles'),
  trousersOutfits('trousers outfits'),
  stylesWithSkirts('stylewithskirts'),
  dressesAndJumpsuits('dresses&jumpsuits');

  final String value;

  const Styles(this.value);
}

enum Hijab {
  all('all'),
  withoutHijab('withouthijab'),
  withHijab('withhijab');

  final String value;

  const Hijab(this.value);
}

enum Seasons {
  allSeasons('allseasons'),
  summerOutfits('summeroutfits'),
  winterOutfits('winterout');

  final String value;

  const Seasons(this.value);
}

Widget circleContainer(List<dynamic> colors) {
  List<Color> listColor = colors.whereType<Color>().toList();
  return Container(
    width: 38.0,
    height: 18.0,
    decoration: colors.length < 2
        ? null
        : BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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

// class SearchModel {
//   final String title;
//   final String icon;
//   final EdgeInsets padding;

//   SearchModel({
//     required this.title,
//     required this.icon,
//     required this.padding,
//   });
// }
