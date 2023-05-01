import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/add_helper.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class FavoriteDetailPage extends StatefulWidget {
  final String page;
  final String folderId;
  final String folderName;
  const FavoriteDetailPage({Key? key, required this.folderName, this.page = "folder", this.folderId = ""}) : super(key: key);

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
    print(widget.page);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(
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
                                  : CustomScrollView(controller: _scrollController, slivers: [
                                      FavImagesGridView(
                                        scrollController: _scrollController,
                                        page: widget.page,
                                        folderId: widget.folderId,
                                        productListData: value.favFoldersImages.data!.data!.data!,
                                        favFoldersViewModel: _favFoldersViewModel,
                                      ),
                                      if (_favFoldersViewModel.getTotalPages != 1)
                                        SliverToBoxAdapter(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 108,
                                            ),
                                            child: Pagination(
                                              onTapBWD: () => value.decreaseTotalPages(),
                                              onTapFWD: () => value.increaseTotalPages(),
                                              numOfPages: _favFoldersViewModel.getTotalPages,
                                              selectedPage: _favFoldersViewModel.getPage,
                                              pagesVisible: 14,
                                              onPageChanged: (index) {
                                                print(index);
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
                                    ]);
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
      ),
    );
  }
}

class FavImagesGridView extends StatefulWidget {
  final List<ProductsData>? productListData;
  final FavFoldersViewModel favFoldersViewModel;
  final String page;
  final String folderId;
  final ScrollController scrollController;
  const FavImagesGridView({
    super.key,
    required this.productListData,
    required this.favFoldersViewModel,
    required this.page,
    required this.scrollController,
    this.folderId = "",
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
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad!.load().then((value) {
      setState(() {
        print("Loaded");
        isLoadedNativeAd = true;
      });
    });
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
              .map((index, value) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: () {
                      print(index);
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
                        ),
                      ).then((value) {
                        print("which");
                        if (widget.page == "wardrobe") {
                          widget.favFoldersViewModel.dressMeImagesList(
                            email: email,
                            ip: ip,
                            userId: userId,
                          );
                        } else {
                          widget.favFoldersViewModel.favFolderImagesList(
                            folderId: widget.folderId,
                            email: email,
                            ip: ip,
                          );
                        }
                      });
                    },
                    child: _ad != null && widget.productListData!.length > 5
                        ? (index == 4)
                            ? Column(
                                children: [
                                  Wrap(
                                    spacing: 16,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                                        height: 230,
                                        width: (width / 2) - 32,
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
                                                print(widget.favFoldersViewModel.favouriteList);
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
                                            child: Image.network(
                                              AppUrl.webUrl + widget.productListData![4].url!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                                        height: 230,
                                        width: (width / 2) - 32,
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
                                                print(widget.favFoldersViewModel.favouriteList);
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
                                            child: Image.network(
                                              AppUrl.webUrl + widget.productListData![5].url!,
                                              fit: BoxFit.fill,
                                            ),
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
                            : index == 7
                                ? Container()
                                : Container(
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
                                            print(widget.favFoldersViewModel.favouriteList);
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
                                        child: Image.network(
                                          AppUrl.webUrl + widget.productListData![index].url!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )
                        : Container(),
                  )))
              .values
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
