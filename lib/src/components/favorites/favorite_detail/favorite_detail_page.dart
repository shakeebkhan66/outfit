import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/data/view_model/wardrobe_view_model.dart';
import 'package:outfit/src/providers/add_helper.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class FavoriteDetailPage extends StatefulWidget {
  final String page;
  final String folderId;
  final String folderName;
  final WardrobeViewModel? wardrobeViewModel;
  final FavFoldersViewModel favFoldersViewModel;
  final FavFoldersViewModel gettingFavFolder;
  const FavoriteDetailPage({
    Key? key,
    required this.folderName,
    this.page = "folder",
    this.folderId = "",
    this.wardrobeViewModel,
    required this.favFoldersViewModel,
    required this.gettingFavFolder,
  }) : super(key: key);

  @override
  State<FavoriteDetailPage> createState() => _FavoriteDetailPageState();
}

class _FavoriteDetailPageState extends State<FavoriteDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final FavFoldersViewModel _favFoldersViewModel = FavFoldersViewModel();
  final String userId = AuthLocalDataSource.getUserid();
  final String ip = AuthLocalDataSource.getIp();
  final String email = AuthLocalDataSource.getEmail();
  @override
  void initState() {
    if (widget.page == "wardrobe") {
      _favFoldersViewModel.dressMeImagesList(
        userId: userId,
        email: email,
        ip: ip,
      );
    } else {
      _favFoldersViewModel.favFolderImagesList(
        folderId: widget.folderId,
        email: email,
        ip: ip,
      );
    }
    _scrollController.addListener(() {
      if (!_favFoldersViewModel.isLoadingImages && _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (_favFoldersViewModel.getCurrentImage < _favFoldersViewModel.getTotalImage) {
          _favFoldersViewModel.setImagesLoading();
          _favFoldersViewModel.loadMoreImages();
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final colorAndStyleProvider = Provider.of<ColorsAndStylesViewModel>(
        context,
        listen: false,
      );
      if (colorAndStyleProvider.colorsList.status == Status.loading) {
        colorAndStyleProvider.fetchColorsList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FavPageTitleWidget(
            title: widget.folderName,
            onCrossback: () {
              if (widget.page == "wardrobe") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: ChangeNotifierProvider.value(
                value: _favFoldersViewModel,
                child: Consumer<FavFoldersViewModel>(
                  builder: (context, value, child) {
                    switch (value.favFoldersImages.status!) {
                      case Status.loading:
                        return const CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.only(top: 12.0),
                              sliver: CustomShimmerLoader(
                                itemCount: 4,
                              ),
                            ),
                          ],
                        );
                      case Status.completed:
                        return value.favFoldersImages.data!.data!.data == null
                            ? EmptyFavImagesFolder(
                                page: widget.page,
                              )
                            : value.favFoldersImages.data!.data!.data!.isEmpty
                                ? EmptyFavImagesFolder(
                                    page: widget.page,
                                  )
                                : CustomScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    controller: _scrollController,
                                    slivers: [
                                      FavImagesGridView(
                                        page: widget.page,
                                        folderId: widget.folderId,
                                        productListData: value.favFoldersImages.data!.data!.data!,
                                        favFoldersViewModel: _favFoldersViewModel,
                                        wardrobeViewModel: widget.wardrobeViewModel!,
                                        loadAdFavFoldersViewModel: widget.favFoldersViewModel,
                                        gettingFolderModel: widget.gettingFavFolder,
                                        showLatest: _favFoldersViewModel.getDisplayImages.length,
                                      ),

                                      if (_favFoldersViewModel.getTotalPages != 1)
                                        value.currentImage < value.totalImages
                                            ? SliverToBoxAdapter(child: Container())
                                            : SliverToBoxAdapter(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
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
                                                                  _favFoldersViewModel.setImagesData();
                                                                  _favFoldersViewModel.setNoPage(value.getPage + 1);
                                                                  _scrollController.animateTo(
                                                                    0,
                                                                    duration: const Duration(milliseconds: 500),
                                                                    curve: Curves.easeInOut,
                                                                  );
                                                                  if (widget.page == "wardrobe") {
                                                                    _favFoldersViewModel.dressMeImagesList(
                                                                      userId: userId,
                                                                      email: email,
                                                                      ip: ip,
                                                                    );
                                                                  } else {
                                                                    _favFoldersViewModel.favFolderImagesList(
                                                                      folderId: widget.folderId,
                                                                      email: email,
                                                                      ip: ip,
                                                                    );
                                                                  }
                                                                  setState(() {});
                                                                },
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                        height: 14.0,
                                                      ),
                                                      Pagination(
                                                        onTapBWD: () {
                                                          _favFoldersViewModel.setImagesData();
                                                          value.decreaseTotalPages();
                                                        },
                                                        onTapFWD: () {
                                                          _favFoldersViewModel.setImagesData();
                                                          value.increaseTotalPages();
                                                        },
                                                        numOfPages: _favFoldersViewModel.getTotalPages,
                                                        selectedPage: _favFoldersViewModel.getPage,
                                                        pagesVisible: 12,
                                                        onPageChanged: (index) {
                                                          _favFoldersViewModel.setImagesData();
                                                          _favFoldersViewModel.setNoPage(index);
                                                          _scrollController.animateTo(
                                                            0,
                                                            duration: const Duration(milliseconds: 500),
                                                            curve: Curves.easeInOut,
                                                          );
                                                          if (widget.page == "wardrobe") {
                                                            _favFoldersViewModel.dressMeImagesList(
                                                              userId: userId,
                                                              email: email,
                                                              ip: ip,
                                                            );
                                                          } else {
                                                            _favFoldersViewModel.favFolderImagesList(
                                                              folderId: widget.folderId,
                                                              email: email,
                                                              ip: ip,
                                                            );
                                                          }
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      //   ChangeNotifierProvider.value(
                                      //   value: _favFoldersViewModel,
                                      //   child: Consumer<ProductsViewModel>(
                                      //     builder: (context, value, child) {
                                      //       return SliverPadding(
                                      //         padding: const EdgeInsets.only(
                                      //           left: 8.0,
                                      //           right: 8.0,
                                      //           bottom: 108,
                                      //           top: 8,
                                      //         ),
                                      //         sliver: SliverToBoxAdapter(
                                      //           child: value.productsList.status == Status.error ?
                                      //               AppButtonWidget(
                                      //                 onTap: (){
                                      //                   if(widget.page == "wardrobe"){
                                      //                     _favFoldersViewModel.dressMeImagesList(
                                      //                       userId: userId,
                                      //                       email: email,
                                      //                       ip: ip,
                                      //                     );
                                      //                   }else {
                                      //                     _favFoldersViewModel.favFolderImagesList(
                                      //                       folderId: widget.folderId,
                                      //                       email: email,
                                      //                       ip: ip,
                                      //                     );
                                      //                   }
                                      //                 },
                                      //                 title: "refresh",
                                      //               ):
                                      //               Row(
                                      //                 children: [
                                      //                   if(_favFoldersViewModel.getPage == 1)
                                      //                   Container()
                                      //                   else
                                      //                   Expanded(
                                      //                     child: AppButtonWidget(
                                      //                       onTap: (){
                                      //                         // favList.clear();
                                      //                         _scrollController.animateTo(
                                      //                           0,
                                      //                           duration: const Duration(milliseconds: 500),
                                      //                           curve: Curves.easeInOut,
                                      //                         );
                                      //                       },
                                      //                       title: "previouspage",
                                      //                       buttonRadius: 5.0,
                                      //                       titleSize: 16.0,
                                      //                       buttonSize: const Size.fromHeight(20.0),
                                      //                     ),
                                      //                   ),
                                      //                   if(_favFoldersViewModel.getPage == _favFoldersViewModel.getTotalPages)
                                      //                   Container()
                                      //                   else
                                      //                   ...[SizedBox(width: _favFoldersViewModel.getPage == 1 ? 0.0 : 10.0,),
                                      //                   Expanded(
                                      //                     child: AppButtonWidget(
                                      //                       onTap: (){
                                      //                         // favList.clear();
                                      //                         _scrollController.animateTo(
                                      //                           0,
                                      //                           duration: const Duration(milliseconds: 500),
                                      //                           curve: Curves.easeInOut,
                                      //                         );
                                      //                         if(widget.page == "wardrobe"){
                                      //                           _favFoldersViewModel.setNextPage();
                                      //                             _favFoldersViewModel.dressMeImagesList(
                                      //                             userId: userId,
                                      //                             email: email,
                                      //                             ip: ip,
                                      //                           );
                                      //                         }else {
                                      //                           _favFoldersViewModel.setNextPage();
                                      //                           _favFoldersViewModel.favFolderImagesList(
                                      //                             folderId: widget.folderId,
                                      //                             email: email,
                                      //                             ip: ip,
                                      //                           );
                                      //                         }
                                      //                       },
                                      //                       title: "nextpage",
                                      //                       titleSize: 18.0,
                                      //                       buttonRadius: 5.0,
                                      //                       buttonSize: const Size.fromHeight(20.0),
                                      //                     ),
                                      //                   ),]
                                      //                 ],
                                      //               ),
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      (value.isLoadingImages && value.currentImage < value.totalImages)
                                          ? const SliverToBoxAdapter(
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.0),
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    color: AppColors.primaryColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SliverToBoxAdapter(child: Container()),
                                    ],
                                  );
                      case Status.error:
                        return Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Some error occured"),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: AppButtonWidget(
                                    onTap: () {
                                      if (widget.page == "wardrobe") {
                                        _favFoldersViewModel.dressMeImagesList(
                                          userId: userId,
                                          email: email,
                                          ip: ip,
                                        );
                                      } else {
                                        _favFoldersViewModel.favFolderImagesList(
                                          folderId: widget.folderId,
                                          email: email,
                                          ip: ip,
                                        );
                                      }
                                    },
                                    title: "refresh",
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavImagesGridView extends StatefulWidget {
  final List<ProductsData>? productListData;
  final FavFoldersViewModel favFoldersViewModel;
  final FavFoldersViewModel loadAdFavFoldersViewModel;
  final FavFoldersViewModel gettingFolderModel;
  final String page;
  final String folderId;
  final WardrobeViewModel wardrobeViewModel;
  final int showLatest;
  const FavImagesGridView({
    super.key,
    required this.productListData,
    required this.favFoldersViewModel,
    required this.page,
    required this.loadAdFavFoldersViewModel,
    required this.wardrobeViewModel,
    required this.gettingFolderModel,
    this.folderId = "",
    required this.showLatest,
  });

  @override
  State<FavImagesGridView> createState() => _FavImagesGridViewState();
}

class _FavImagesGridViewState extends State<FavImagesGridView> {
  final String email = AuthLocalDataSource.getEmail();
  final String ip = AuthLocalDataSource.getIp();
  final String userId = AuthLocalDataSource.getUserid();
  ProductsViewModel productsViewModel = ProductsViewModel();
  NativeAd? _ad;
  bool isLoadedNativeAd = false;
  bool isLoadAdFailed = false;
  @override
  void initState() {
    super.initState();
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as NativeAd;
            isLoadAdFailed = false;
          });
          _ad!.load();
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            isLoadAdFailed = true;
          });
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    );
    _ad!.load().then((value) {
      setState(() {
        isLoadedNativeAd = true;
      });
    });
  }

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
        return const Column(
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
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 30.0,
        top: 8.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Wrap(
          spacing: 16,
          children: widget.productListData!
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  _ad != null && widget.productListData!.length > 5
                      ? (index == 4)
                          ? Column(
                              children: [
                                Wrap(
                                  spacing: 16,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        AppNavigation.to(
                                          context,
                                          DressDetailPage(
                                            productViewModel: productsViewModel,
                                            favFoldersViewModel: widget.loadAdFavFoldersViewModel,
                                            isFavourite: widget.favFoldersViewModel.favouriteList.contains(4) ? true : false,
                                            dress: AppUrl.webUrl + widget.productListData![4].url!,
                                            source: widget.productListData![4].source!,
                                            imageId: widget.productListData![4].uid.toString(),
                                            index: 4,
                                            id: widget.productListData![4].uid!,
                                            page: "favourites",
                                            loadAdFavFoldersViewModel: widget.favFoldersViewModel,
                                            gettingFolderModel: widget.gettingFolderModel,
                                          ),
                                        ).then((value) {});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                                        width: (width / 2) - 32,
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
                                                    onTap: () => AppUtils.share(widget.productListData![4].uid!, currentLanguage.languageCode),
                                                    child: const Icon(
                                                      Icons.share,
                                                      color: AppColors.blackColor,
                                                    ),
                                                  ),
                                                  title: const Text(""),
                                                  trailing: GestureDetector(
                                                    onTap: () {
                                                      if (widget.favFoldersViewModel.favouriteList.contains(4)) {
                                                        widget.favFoldersViewModel.removeFromFavourite(4);
                                                        widget.favFoldersViewModel.decrementFromFavourite(4);
                                                        productsViewModel.unLikeImageById(
                                                            email: email, ip: ip, id: widget.productListData![4].uid!.toString());
                                                      } else {
                                                        widget.favFoldersViewModel.addFromFavourite(4);
                                                        widget.favFoldersViewModel.incrementFromFavourite(4);
                                                        productsViewModel.likeImageById(
                                                            email: email, ip: ip, id: widget.productListData![4].uid!.toString());
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      widget.favFoldersViewModel.favouriteList.contains(4) ? Icons.favorite : Icons.favorite_border,
                                                      color: widget.favFoldersViewModel.favouriteList.contains(4)
                                                          ? const Color(0xFFFF2C2C)
                                                          : AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  child: _networkImage(AppUrl.webUrl + widget.productListData![4].url!),
                                                ),
                                              ),
                                            ),
                                            if (widget.page == "wardrobe")
                                              ColorWidget(
                                                wardrobeViewModel: widget.wardrobeViewModel,
                                                i: 4,
                                                products: widget.productListData!,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        AppNavigation.to(
                                          context,
                                          DressDetailPage(
                                              productViewModel: productsViewModel,
                                              favFoldersViewModel: widget.favFoldersViewModel,
                                              isFavourite: widget.favFoldersViewModel.favouriteList.contains(5) ? true : false,
                                              dress: AppUrl.webUrl + widget.productListData![5].url!,
                                              source: widget.productListData![5].source!,
                                              imageId: widget.productListData![5].uid.toString(),
                                              index: 5,
                                              id: widget.productListData![5].uid!,
                                              page: "favourites",
                                              loadAdFavFoldersViewModel: widget.loadAdFavFoldersViewModel,
                                              gettingFolderModel: widget.gettingFolderModel),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                                        width: (width / 2) - 32,
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
                                                    onTap: () => AppUtils.share(widget.productListData![5].uid!, currentLanguage.languageCode),
                                                    child: const Icon(
                                                      Icons.share,
                                                      color: AppColors.blackColor,
                                                    ),
                                                  ),
                                                  title: const Text(""),
                                                  trailing: GestureDetector(
                                                    onTap: () {
                                                      if (widget.favFoldersViewModel.favouriteList.contains(5)) {
                                                        widget.favFoldersViewModel.removeFromFavourite(5);
                                                        widget.favFoldersViewModel.decrementFromFavourite(5);
                                                        productsViewModel.unLikeImageById(
                                                            email: email, ip: ip, id: widget.productListData![5].uid!.toString());
                                                      } else {
                                                        widget.favFoldersViewModel.addFromFavourite(5);
                                                        widget.favFoldersViewModel.incrementFromFavourite(5);
                                                        productsViewModel.likeImageById(
                                                            email: email, ip: ip, id: widget.productListData![5].uid!.toString());
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      widget.favFoldersViewModel.favouriteList.contains(5) ? Icons.favorite : Icons.favorite_border,
                                                      color: widget.favFoldersViewModel.favouriteList.contains(5)
                                                          ? const Color(0xFFFF2C2C)
                                                          : AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  child: _networkImage(
                                                    AppUrl.webUrl + widget.productListData![5].url!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (widget.page == "wardrobe")
                                              ColorWidget(
                                                products: widget.productListData!,
                                                i: 5,
                                                wardrobeViewModel: widget.wardrobeViewModel,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (widget.page == "wardrobe")
                                      _ad != null && isLoadedNativeAd
                                          ? Container(
                                              margin: EdgeInsets.zero,
                                              height: 120.0,
                                              alignment: Alignment.center,
                                              child: AdWidget(ad: _ad!),
                                            )
                                          : Container(),
                                  ],
                                ),
                              ],
                            )
                          : index == 5
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    AppNavigation.to(
                                      context,
                                      DressDetailPage(
                                          productViewModel: productsViewModel,
                                          favFoldersViewModel: widget.favFoldersViewModel,
                                          isFavourite: widget.favFoldersViewModel.favouriteList.contains(index) ? true : false,
                                          dress: AppUrl.webUrl + widget.productListData![index].url!,
                                          source: widget.productListData![index].source!,
                                          imageId: widget.productListData![index].uid.toString(),
                                          index: index,
                                          id: widget.productListData![index].uid!,
                                          page: "favourites",
                                          loadAdFavFoldersViewModel: widget.favFoldersViewModel,
                                          gettingFolderModel: widget.gettingFolderModel),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 7.0),
                                    width: (width / 2) - 32,
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
                                                onTap: () => AppUtils.share(widget.productListData![index].uid!, currentLanguage.languageCode),
                                                child: const Icon(
                                                  Icons.share,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                              title: const Text(""),
                                              trailing: GestureDetector(
                                                onTap: () {
                                                  if (widget.favFoldersViewModel.favouriteList.contains(index)) {
                                                    widget.favFoldersViewModel.removeFromFavourite(index);
                                                    widget.favFoldersViewModel.decrementFromFavourite(index);
                                                    productsViewModel.unLikeImageById(
                                                        email: email, ip: ip, id: widget.productListData![index].uid!.toString());
                                                  } else {
                                                    widget.favFoldersViewModel.addFromFavourite(index);
                                                    widget.favFoldersViewModel.incrementFromFavourite(index);
                                                    productsViewModel.likeImageById(
                                                        email: email, ip: ip, id: widget.productListData![index].uid!.toString());
                                                  }
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  widget.favFoldersViewModel.favouriteList.contains(index) ? Icons.favorite : Icons.favorite_border,
                                                  color: widget.favFoldersViewModel.favouriteList.contains(index)
                                                      ? const Color(0xFFFF2C2C)
                                                      : AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5.0),
                                              child: _networkImage(
                                                AppUrl.webUrl + widget.productListData![index].url!,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (widget.page == "wardrobe")
                                          ColorWidget(
                                            i: index,
                                            products: widget.productListData!,
                                            wardrobeViewModel: widget.wardrobeViewModel,
                                          )
                                      ],
                                    ),
                                  ),
                                )
                      : GestureDetector(
                          onTap: () {
                            AppNavigation.to(
                              context,
                              DressDetailPage(
                                  productViewModel: productsViewModel,
                                  favFoldersViewModel: widget.favFoldersViewModel,
                                  isFavourite: widget.favFoldersViewModel.favouriteList.contains(index) ? true : false,
                                  dress: AppUrl.webUrl + widget.productListData![index].url!,
                                  source: widget.productListData![index].source!,
                                  imageId: widget.productListData![index].uid.toString(),
                                  index: index,
                                  id: widget.productListData![index].uid!,
                                  page: "favourites",
                                  loadAd: "yes",
                                  loadAdFavFoldersViewModel: widget.favFoldersViewModel,
                                  gettingFolderModel: widget.gettingFolderModel),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            height: 230,
                            width: (width / 2) - 32,
                            child: GridTile(
                              footer: GridTileBar(
                                leading: GestureDetector(
                                  onTap: () => AppUtils.share(widget.productListData![index].uid!, currentLanguage.languageCode),
                                  child: const Icon(
                                    Icons.share,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                title: const Text(""),
                                trailing: GestureDetector(
                                  onTap: () {
                                    if (widget.favFoldersViewModel.favouriteList.contains(index)) {
                                      widget.favFoldersViewModel.removeFromFavourite(index);
                                      widget.favFoldersViewModel.decrementFromFavourite(index);
                                      productsViewModel.unLikeImageById(email: email, ip: ip, id: widget.productListData![index].uid!.toString());
                                    } else {
                                      widget.favFoldersViewModel.addFromFavourite(index);
                                      widget.favFoldersViewModel.incrementFromFavourite(index);
                                      productsViewModel.likeImageById(email: email, ip: ip, id: widget.productListData![index].uid!.toString());
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    widget.favFoldersViewModel.favouriteList.contains(index) ? Icons.favorite : Icons.favorite_border,
                                    color: widget.favFoldersViewModel.favouriteList.contains(index) ? const Color(0xFFFF2C2C) : AppColors.blackColor,
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: _networkImage(
                                  AppUrl.webUrl + widget.productListData![index].url!,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              )
              .values
              .take(widget.showLatest)
              .toList(),
        ),
      ),
    );
  }
}

class EmptyFavImagesFolder extends StatefulWidget {
  final String page;
  const EmptyFavImagesFolder({super.key, required this.page});

  @override
  State<EmptyFavImagesFolder> createState() => _EmptyFavImagesFolderState();
}

class _EmptyFavImagesFolderState extends State<EmptyFavImagesFolder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: AppShadow.primaryShadow,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 39,
            horizontal: 24,
          ),
          margin: const EdgeInsets.fromLTRB(26, 65, 27, 86),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 67,
              horizontal: 48,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4FB).withOpacity(0.8),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            child: Text(
              AppLocalization.of(context)!.getTranslatedValues(widget.page == "wardrobe" ? "youdidntaddcolor" : "youdidntaddimage")!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        widget.page == "wardrobe" ? Container() : Image.asset(AppAssets.folderDetail)
      ]),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final WardrobeViewModel wardrobeViewModel;
  final List<ProductsData> products;
  final int i;
  const ColorWidget({super.key, required this.products, required this.i, required this.wardrobeViewModel});

  @override
  Widget build(BuildContext context) {
    // final colorsViewModelProvider = Provider.of<ColorsAndStylesViewModel>(context);
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final color1Data = wardrobeViewModel.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color!,
    );
    final type1Data = wardrobeViewModel.wardRobe.where(
      (element) => element.id == products[i].type.toString(),
    );
    final color2Data = wardrobeViewModel.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color2!,
    );
    final type2Data = wardrobeViewModel.wardRobe.where(
      (element) => element.id == products[i].type2.toString(),
    );
    final color3Data = wardrobeViewModel.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color3!,
    );
    final type3Data = wardrobeViewModel.wardRobe.where(
      (element) => element.id == products[i].type3!.toString(),
    );
    final color4Data = wardrobeViewModel.colorsList.data!.colorsModel.data!.where(
      (element) => element.cid == products[i].color4,
    );
    final type4Data = wardrobeViewModel.wardRobe.where(
      (element) => element.id == products[i].type4.toString(),
    );

    bool getTrueIfColor1Search() {
      if (color1Data.isNotEmpty) {
        if (wardrobeViewModel.getSelectedColors[type1Data.first.id]!.contains(
          color1Data.first.cid.toString(),
        )) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    // bool getTrueIfType1Search() {
    //   if (type1Data.isNotEmpty) {
    //     if (wardrobeViewModel.getSelectedColors[type1Data.first.tid]!.contains(
    //       type1Data.first.tid.toString(),
    //     )) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // }

    bool getTrueIfColor2Search() {
      if (color2Data.isNotEmpty) {
        if (wardrobeViewModel.getSelectedColors[type2Data.first.id]!.contains(
          color2Data.first.cid.toString(),
        )) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    // bool getTrueIfType2Search() {
    //   if (type2Data.isNotEmpty) {
    //     if (filterPairProvider.getSearchType.contains(type2Data.first.tid)) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // }

    bool getTrueIfColor3Search() {
      if (color3Data.isNotEmpty) {
        if (wardrobeViewModel.getSelectedColors[type3Data.first.id]!.contains(
          color3Data.first.cid.toString(),
        )) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    // bool getTrueIfType3Search() {
    //   if (type3Data.isNotEmpty) {
    //     if (filterPairProvider.getSearchType.contains(type3Data.first.tid)) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // }

    bool getTrueIfColor4Search() {
      if (color4Data.isNotEmpty) {
        if (wardrobeViewModel.getSelectedColors[type4Data.first.id]!.contains(
          color4Data.first.cid.toString(),
        )) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    // bool getTrueIfType4Search() {
    //   if (type4Data.isNotEmpty) {
    //     if (filterPairProvider.getSearchType.contains(type4Data.first.tid)) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   } else {
    //     return false;
    //   }
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (getTrueIfColor1Search())
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
                        child: Text(currentLanguage.languageCode == "en" ? type1Data.first.title.toString() : type1Data.first.arabicTitle.toString()),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor2Search())
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
                          currentLanguage.languageCode == "en" ? type2Data.first.title.toString() : type2Data.first.arabicTitle.toString(),
                        ),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor3Search())
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
                          currentLanguage.languageCode == "en" ? type3Data.first.title.toString() : type3Data.first.arabicTitle.toString(),
                        ),
                      )
                    : Container(),
              ],
            ),
          if (getTrueIfColor4Search())
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
                        child: Text(
                          currentLanguage.languageCode == "en" ? type4Data.first.title.toString() : type4Data.first.arabicTitle.toString(),
                        ),
                      )
                    : Container(),
              ],
            ),
        ],
      ),
    );
  }
}
