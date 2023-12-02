import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/favorites_folders_page.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/components/home/widget/drawer_widget.dart';
import 'package:outfit/src/components/search/search_page.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart' as fav;
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/add_helper.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/custom_webview_drawer.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/refresh_widget.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:visibility_detector/visibility_detector.dart';

T? ambiguate<T>(T? object) => object;

class OutfitIdeasView extends StatefulWidget {
  final ProductsViewModel productViewModel;
  final GlobalKey outfitViewGuideKey;
  const OutfitIdeasView({Key? key, required this.productViewModel, required this.outfitViewGuideKey}) : super(key: key);

  @override
  State<OutfitIdeasView> createState() => _OutfitIdeasViewState();
}

class _OutfitIdeasViewState extends State<OutfitIdeasView> {
  final _scrollController = ScrollController();
  final String email = AuthLocalDataSource.getEmail();
  bool isLoadAdFailed = false;
  bool filterDrawer = true;
  bool isLoadedNativeAd = false;
  int pageSize = 8;
  @override
  void initState() {
    setState(() {
      isLoadedNativeAd = true;
    });
    final productViewProvider = Provider.of<ProductsViewModel>(context, listen: false);
    if (productViewProvider.pageName == "search") {
      print("This is search page");
    } else {
      widget.productViewModel.fetchPhotosList(
        context: context,
        email: email,
      );
    }
    _scrollController.addListener(() {
      var nextPageTrigger = 0.7 * _scrollController.position.maxScrollExtent;
      print("${_scrollController.position.pixels}:${nextPageTrigger}");

      if (_scrollController.position.pixels >nextPageTrigger) {
        if (widget.productViewModel.getCurrentImage < widget.productViewModel.getTotalImage) {
          print('its here now');
          widget.productViewModel.setImagesLoading();
          widget.productViewModel.loadMoreImages();
        } else {
          if (widget.productViewModel.isLoadingImages) {
            widget.productViewModel.setImagesLoadingfalse();
          }
        }
      }
    });
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
  InterstitialAd? interstitialAd;
  void _loadInterstitialAd(String ads) {
    InterstitialAd.load(
      adUnitId: ads == "apply" ? AdHelper.favAndFilterAdUnitId : AdHelper.searchAndWardrobeAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );
          setState(() {
            interstitialAd = ad;
          });
          interstitialAd!.show();
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  _networkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      cacheManager: CacheManager(
        Config(
          "outfit",
          stalePeriod: const Duration(days: 4),
          maxNrOfCacheObjects: 72,
          //one week cache period
        ),
      ),
      height: 230.0,
      errorWidget: (context, error, stackTrace) {
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.error),
            ),
            Text("Network error"),
          ],
        );
      },
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
              applyCallback: (apply) {
                _loadInterstitialAd(apply);
              },
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
            _loadInterstitialAd("fav");
            AppNavigation.to(context, const FavoritesFolderPage());
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
        cacheExtent: 100.0,
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
                      callback: () {},
                    ),
                  );
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
                    AppLocalization.of(context)!.getTranslatedValues("outfitideas")!,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  if (productViewProvider.getPageName == "search")
                    InkWell(
                      onTap: () {
                        filterPairProvider.clearaddNullAtEnd();
                        colorsViewModelProvider.clearStyleAndColorSearch();
                        widget.productViewModel.setCurrentPage(Pages.products);
                        productViewProvider.setPage('outfit');
                        widget.productViewModel.fetchPhotosList(email: email, context: context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6F8),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            if (currentLanguage.languageCode == "en") ...[
                              const Icon(
                                Icons.arrow_back_ios,
                                size: 15.0,
                              ),
                              const SizedBox(width: 4.0),
                            ] else
                              Container(),
                            Text(
                              AppLocalization.of(context)!.getTranslatedValues("back")!,
                              style: const TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                            if (currentLanguage.languageCode == "ar") ...[
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                              )
                            ] else
                              Container(),
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
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 30.0,
              top: 4,
            ),
            sliver: SliverToBoxAdapter(
              child: Showcase(
                targetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                titleTextStyle: const TextStyle(color: Colors.black),
                descTextStyle: const TextStyle(color: Colors.black, fontSize: 13.0),
                onToolTipClick: () async {
                  await AuthLocalDataSource.setTutorial4();
                },
                onTargetClick: () async {
                  await AuthLocalDataSource.setTutorial4();
                },
                disposeOnTap: true,
                key: widget.outfitViewGuideKey,
                title: AppLocalization.of(context)!.getTranslatedValues("explaination4")!,
                description: AppLocalization.of(context)!.getTranslatedValues("explaination5")!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (colorsViewModelProvider.selectedGradientColors[0] == null || productViewProvider.getPageName != "search")
                      Container()
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Wrap(
                          runSpacing: 8,
                          spacing: 16,
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
                    ChangeNotifierProvider.value(
                      value: widget.productViewModel,
                      child: Consumer<ProductsViewModel>(
                        builder: (context, value, child) {
                          switch (value.productsList.status!) {
                            case Status.completed:
                              List<ProductsData> products = value.productsList.data!.data!.data!;
                              return Column(
                                children: [
                                  Wrap(
                                    runSpacing: 0,
                                    spacing: 16,
                                    children: products
                                        .asMap()
                                        .map(
                                          (i, value) => MapEntry(
                                            i,
                                            i == 7
                                                ? Container()
                                                : i == 6
                                                    ? Wrap(
                                                        runSpacing: 0,
                                                        spacing: 16,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              AppNavigation.to(
                                                                context,
                                                                DressDetailPage(
                                                                  productViewModel: widget.productViewModel,
                                                                  isFavourite: widget.productViewModel.getFavouriteList.contains(6) ? true : false,
                                                                  dress: AppUrl.webUrl + products[6].url!,
                                                                  source: products[6].source!,
                                                                  imageId: products[6].uid.toString(),
                                                                  index: 6,
                                                                  id: products[6].uid!,
                                                                  page: "outfit",
                                                                  favFoldersViewModel: fav.FavFoldersViewModel(),
                                                                  loadAdFavFoldersViewModel: fav.FavFoldersViewModel(),
                                                                  gettingFolderModel: fav.FavFoldersViewModel(),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              margin: const EdgeInsets.symmetric(vertical: 7.0),
                                                              width: (width / 2) - 24,
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey.withOpacity(0.2),
                                                                borderRadius: BorderRadius.circular(15.0),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 230,
                                                                    child: GridTile(
                                                                      footer: GridTileBar(
                                                                        leading: GestureDetector(
                                                                          onTap: () => AppUtils.share(products[6].uid!, currentLanguage.languageCode),
                                                                          child: const Icon(
                                                                            Icons.share,
                                                                            color: AppColors.blackColor,
                                                                          ),
                                                                        ),
                                                                        title: const Text(""),
                                                                        trailing: GestureDetector(
                                                                          onTap: () {
                                                                            if (widget.productViewModel.favouriteList.contains(6)) {
                                                                              widget.productViewModel.removeFromFavourite(6);
                                                                              widget.productViewModel.decrementFromFavourite(6);
                                                                              widget.productViewModel
                                                                                  .unLikeImageById(email: email, id: products[6].uid!.toString());
                                                                            } else {
                                                                              widget.productViewModel.addFromFavourite(6);
                                                                              widget.productViewModel.incrementFromFavourite(6);
                                                                              widget.productViewModel
                                                                                  .likeImageById(email: email, id: products[6].uid!.toString());
                                                                            }
                                                                          },
                                                                          child: Icon(
                                                                            widget.productViewModel.favouriteList.contains(6)
                                                                                ? Icons.favorite
                                                                                : Icons.favorite_border,
                                                                            color: widget.productViewModel.favouriteList.contains(6)
                                                                                ? const Color(0xFFFF2C2C)
                                                                                : AppColors.blackColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                        child: _networkImage(
                                                                          AppUrl.webUrl + products[6].url!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (productViewProvider.getPageName == "search" &&
                                                                      filterPairProvider.getSearchColor.length > 1)
                                                                    ColorWidget(
                                                                      products: products,
                                                                      i: 6,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              AppNavigation.to(
                                                                context,
                                                                DressDetailPage(
                                                                  productViewModel: widget.productViewModel,
                                                                  isFavourite: widget.productViewModel.getFavouriteList.contains(7) ? true : false,
                                                                  dress: AppUrl.webUrl + products[7].url!,
                                                                  source: products[7].source!,
                                                                  imageId: products[7].uid.toString(),
                                                                  index: 7,
                                                                  id: products[7].uid!,
                                                                  page: "outfit",
                                                                  favFoldersViewModel: fav.FavFoldersViewModel(),
                                                                  loadAdFavFoldersViewModel: fav.FavFoldersViewModel(),
                                                                  gettingFolderModel: fav.FavFoldersViewModel(),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              margin: const EdgeInsets.symmetric(vertical: 7.0),
                                                              width: (width / 2) - 24,
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey.withOpacity(0.2),
                                                                borderRadius: BorderRadius.circular(15.0),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 230,
                                                                    child: GridTile(
                                                                      footer: GridTileBar(
                                                                        leading: GestureDetector(
                                                                          onTap: () => AppUtils.share(products[7].uid!, currentLanguage.languageCode),
                                                                          child: const Icon(
                                                                            Icons.share,
                                                                            color: AppColors.blackColor,
                                                                          ),
                                                                        ),
                                                                        title: const Text(""),
                                                                        trailing: GestureDetector(
                                                                          onTap: () {
                                                                            if (widget.productViewModel.favouriteList.contains(7)) {
                                                                              widget.productViewModel.removeFromFavourite(7);
                                                                              widget.productViewModel.decrementFromFavourite(7);
                                                                              widget.productViewModel
                                                                                  .unLikeImageById(email: email, id: products[7].uid!.toString());
                                                                            } else {
                                                                              widget.productViewModel.addFromFavourite(7);
                                                                              widget.productViewModel.incrementFromFavourite(7);
                                                                              widget.productViewModel
                                                                                  .likeImageById(email: email, id: products[7].uid!.toString());
                                                                            }
                                                                          },
                                                                          child: Icon(
                                                                            widget.productViewModel.favouriteList.contains(7)
                                                                                ? Icons.favorite
                                                                                : Icons.favorite_border,
                                                                            color: widget.productViewModel.favouriteList.contains(7)
                                                                                ? const Color(0xFFFF2C2C)
                                                                                : AppColors.blackColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                        child: _networkImage(
                                                                          AppUrl.webUrl + products[7].url!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (productViewProvider.getPageName == "search" &&
                                                                      filterPairProvider.getSearchColor.length > 1)
                                                                    ColorWidget(
                                                                      products: products,
                                                                      i: 7,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // _ad != null && isLoadedNativeAd
                                                          //     ? Container(
                                                          //         margin: EdgeInsets.zero,
                                                          //         height: 120.0,
                                                          //         alignment: Alignment.center,
                                                          //         child: AdWidget(ad: _ad!),
                                                          //       )
                                                          //     : Container(),
                                                        ],
                                                      )
                                                    : GestureDetector(
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
                                                              favFoldersViewModel: fav.FavFoldersViewModel(),
                                                              loadAdFavFoldersViewModel: fav.FavFoldersViewModel(),
                                                              gettingFolderModel: fav.FavFoldersViewModel(),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          margin: const EdgeInsets.symmetric(vertical: 7.0),
                                                          width: (width / 2) - 24,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.withOpacity(0.2),
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 230,
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
                                                                          widget.productViewModel
                                                                              .unLikeImageById(email: email, id: products[i].uid!.toString());
                                                                        } else {
                                                                          widget.productViewModel.addFromFavourite(i);
                                                                          widget.productViewModel.incrementFromFavourite(i);
                                                                          widget.productViewModel
                                                                              .likeImageById(email: email, id: products[i].uid!.toString());
                                                                        }
                                                                      },
                                                                      child: Icon(
                                                                        widget.productViewModel.favouriteList.contains(i)
                                                                            ? Icons.favorite
                                                                            : Icons.favorite_border,
                                                                        color: widget.productViewModel.favouriteList.contains(i)
                                                                            ? const Color(0xFFFF2C2C)
                                                                            : AppColors.blackColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                    child: _networkImage(
                                                                      AppUrl.webUrl + products[i].url!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (productViewProvider.getPageName == "search" &&
                                                                  filterPairProvider.getSearchColor.length > 1)
                                                                ColorWidget(
                                                                  products: products,
                                                                  i: i,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                          ),
                                        )
                                        .values
                                        .take(widget.productViewModel.getDisplayImages.length)
                                        .toList(),
                                  ),
                                  ChangeNotifierProvider.value(
                                    value: widget.productViewModel,
                                    child: Consumer<ProductsViewModel>(
                                      builder: (context, loadingvalue, child) {
                                        return value.isLoadingImages
                                            ? CustomShimmerLoader2(
                                          itemCount: 4
                                        )
                                            : Container();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            case Status.error:
                              return RefreshWidget(
                                error: value.productsList.message.toString(),
                                onRefresh: () {
                                  if (productViewProvider.getPageName == "search") {
                                    widget.productViewModel.fetchFilterPairList(
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
                                    );
                                  } else if (productViewProvider.getPageName == "filter") {
                                    widget.productViewModel.filterPhotoPhotosList(
                                      context: context,
                                      email: email,
                                    );
                                  } else {
                                    widget.productViewModel.fetchPhotosList(
                                      context: context,
                                      email: email,
                                    );
                                  }
                                },
                              );
                            case Status.loading:
                              return const CustomShimmerLoader2(
                                itemCount: 10,
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ChangeNotifierProvider.value(
            value: widget.productViewModel,
            child: Consumer<ProductsViewModel>(
              builder: (context, value, child) {
                return value.isLoadingImages
                    ? const SliverPadding(padding: EdgeInsets.only(bottom: 80.0))
                    : SliverToBoxAdapter(
                        child: Container(),
                      );
              },
            ),
          ),
          ChangeNotifierProvider.value(
            value: widget.productViewModel,
            child: Consumer<ProductsViewModel>(
              builder: (context, value, child) {
                switch (value.productsList.status!) {
                  case Status.completed:
                    return value.isLoadingImages
                        ? SliverToBoxAdapter(child: Container())
                        : SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                bottom: 108,
                              ),
                              child: Column(
                                children: [
                                  value.totalPages == value.page
                                      ? Container()
                                      : SizedBox(
                                          height: 40.0,
                                          width: 120.0,
                                          child: AppButtonWidget(
                                            buttonRadius: 5.0,
                                            titleSize: 16.0,
                                            title: "nextpage",
                                            onTap: () {
                                              widget.productViewModel.setImagesData();
                                              value.setNoPage(value.getPage + 1);
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
                                                );
                                              } else if (value.getCurrentPage == Pages.filter) {
                                                productViewProvider.setPage("filter");
                                                value.filterPhotoPhotosList(
                                                  context: context,
                                                  email: email,
                                                );
                                              } else if (value.getCurrentPage == Pages.search) {
                                                productViewProvider.setPage("search");
                                                value.fetchFilterPairList(
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
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 14.0,
                                  ),
                                  Pagination(
                                    onTapFWD: () {
                                      widget.productViewModel.setImagesData();
                                      value.increaseTotalPages();
                                    },
                                    onTapBWD: () {
                                      widget.productViewModel.setImagesData();
                                      value.decreaseTotalPages();
                                    },
                                    numOfPages: value.getTotalPages,
                                    selectedPage: value.getPage,
                                    pagesVisible: 12,
                                    onPageChanged: (index) {
                                      widget.productViewModel.setImagesData();
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
                                        );
                                      } else if (value.getCurrentPage == Pages.filter) {
                                        productViewProvider.setPage("filter");
                                        value.filterPhotoPhotosList(
                                          context: context,
                                          email: email,
                                        );
                                      } else if (value.getCurrentPage == Pages.search) {
                                        productViewProvider.setPage("search");
                                        value.fetchFilterPairList(
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
                                        );
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
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

class ColorWidget extends StatelessWidget {
  final List<ProductsData> products;
  final int i;
  const ColorWidget({super.key, required this.products, required this.i});

  @override
  Widget build(BuildContext context) {
    final colorsViewModelProvider = Provider.of<ColorsAndStylesViewModel>(context);
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final filterPairProvider = Provider.of<FilterPairProvider>(context);

    final color1Data = colorsViewModelProvider.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color!,
    );
    final type1Data = colorsViewModelProvider.colorsList.data!.typesModel.data!.where(
      (element) => element.tid == products[i].type!,
    );
    final color2Data = colorsViewModelProvider.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color2!,
    );
    final type2Data = colorsViewModelProvider.colorsList.data!.typesModel.data!.where(
      (element) => element.tid == products[i].type2!,
    );
    final color3Data = colorsViewModelProvider.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color3!,
    );
    final type3Data = colorsViewModelProvider.colorsList.data!.typesModel.data!.where(
      (element) => element.tid == products[i].type3!,
    );
    final color4Data = colorsViewModelProvider.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color4,
    );
    final type4Data = colorsViewModelProvider.colorsList.data!.typesModel.data!.where(
      (element) => element.tid == products[i].type4,
    );

    bool getTrueIfColor1Search() {
      if (color1Data.isNotEmpty) {
        if (filterPairProvider.getSearchColor.contains(color1Data.first.cid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfType1Search() {
      if (type1Data.isNotEmpty) {
        if (filterPairProvider.getSearchType.contains(type1Data.first.tid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfColor2Search() {
      if (color2Data.isNotEmpty) {
        if (filterPairProvider.getSearchColor.contains(color2Data.first.cid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfType2Search() {
      if (type2Data.isNotEmpty) {
        if (filterPairProvider.getSearchType.contains(type2Data.first.tid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfColor3Search() {
      if (color3Data.isNotEmpty) {
        if (filterPairProvider.getSearchColor.contains(color3Data.first.cid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfType3Search() {
      if (type3Data.isNotEmpty) {
        if (filterPairProvider.getSearchType.contains(type3Data.first.tid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfColor4Search() {
      if (color4Data.isNotEmpty) {
        if (filterPairProvider.getSearchColor.contains(color4Data.first.cid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    bool getTrueIfType4Search() {
      if (type4Data.isNotEmpty) {
        if (filterPairProvider.getSearchType.contains(type4Data.first.tid)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (getTrueIfColor1Search() && getTrueIfType1Search())
            Row(
              children: [
                products[i].color != 0
                    ? color1Data.first.pattern == ""
                        ? getColorContainer(
                            [
                              hexToColor(
                                color1Data.first.hex!,
                              ),
                              hexToColor(color1Data.first.hex!).withOpacity(0.1),
                            ],
                          )
                        : getImage(color1Data.first.pattern!)
                    : Container(),
                const SizedBox(
                  width: 5.0,
                ),
                products[i].type != 0
                    ? Expanded(
                        child: Text(currentLanguage.languageCode == "en" ? type1Data.first.en_name.toString() : type1Data.first.name.toString()),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor2Search() && getTrueIfType2Search())
            Row(
              children: [
                products[i].color2 != 0
                    ? color2Data.first.pattern == ""
                        ? getColorContainer(
                            [
                              hexToColor(
                                color2Data.first.hex!,
                              ),
                              hexToColor(color2Data.first.hex!).withOpacity(0.1),
                            ],
                          )
                        : getImage(color2Data.first.pattern!)
                    : Container(),
                const SizedBox(
                  width: 5.0,
                ),
                products[i].type2 != 0
                    ? Expanded(
                        child: Text(
                          currentLanguage.languageCode == "en" ? type2Data.first.en_name.toString() : type2Data.first.name.toString(),
                        ),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor3Search() && getTrueIfType3Search())
            Row(
              children: [
                products[i].color3 != 0
                    ? color3Data.first.pattern == ""
                        ? getColorContainer(
                            [
                              hexToColor(
                                color3Data.first.hex!,
                              ),
                              hexToColor(color3Data.first.hex!).withOpacity(0.1),
                            ],
                          )
                        : getImage(color3Data.first.pattern!)
                    : Container(),
                const SizedBox(
                  width: 5.0,
                ),
                products[i].type3 != 0
                    ? Expanded(
                        child: Text(
                          currentLanguage.languageCode == "en" ? type3Data.first.en_name.toString() : type3Data.first.name.toString(),
                        ),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor4Search() && getTrueIfType4Search())
            Row(
              children: [
                products[i].color4 != 0 && color4Data.isNotEmpty
                    ? color4Data.first.pattern == ""
                        ? getColorContainer(
                            [
                              hexToColor(
                                color4Data.first.hex!,
                              ),
                              hexToColor(color4Data.first.hex!).withOpacity(0.1),
                            ],
                          )
                        : getImage(color4Data.first.pattern!)
                    : Container(),
                const SizedBox(
                  width: 5.0,
                ),
                products[i].type4 != 0 && type4Data.isNotEmpty
                    ? Expanded(
                        child: Text(currentLanguage.languageCode == "en" ? type4Data.first.en_name.toString() : type4Data.first.name.toString()),
                      )
                    : Container(),
              ],
            ),
        ],
      ),
    );
  }
}
