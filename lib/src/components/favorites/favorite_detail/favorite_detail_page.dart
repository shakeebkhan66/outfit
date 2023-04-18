

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteDetailPage extends StatefulWidget {
  final String page;
  final String folderId;
  final String folderName;
  const FavoriteDetailPage({Key? key, required this.folderName, this.page = "folder", this.folderId=""}) : super(key: key);

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
    if(widget.page == "wardrobe"){
      _favFoldersViewModel.dressMeImagesList(
        userId: userId,
        email: email,
        ip: ip,
      );
    }else {
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
              onCrossback: (){
                if(widget.page == "wardrobe") {
                  Navigator.of(context).pop();
                }else {
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
                          slivers:[ 
                            SliverPadding(
                              padding: EdgeInsets.only(top: 12.0),
                              sliver: CustomShimmerLoader(
                                itemCount: 4,
                              ),
                            ),
                          ],
                        );
                        case Status.completed:
                        return value.favFoldersImages.data!.data!.data == null ?
                         const EmptyFavImagesFolder()
                         : value.favFoldersImages.data!.data!.data!.isEmpty?
                         const EmptyFavImagesFolder():
                         CustomScrollView(
                          controller: _scrollController,
                           slivers: [
                            FavImagesGridView(
                            scrollController: _scrollController,
                            page: widget.page,
                            folderId: widget.folderId,
                            productListData: value.favFoldersImages.data!.data!.data!,
                            favFoldersViewModel: _favFoldersViewModel,
                            ),
                            SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 108,
                              ),
                              child: Pagination(
                                numOfPages: _favFoldersViewModel.getTotalPages, 
                                selectedPage: _favFoldersViewModel.getPage, 
                                pagesVisible: 14, 
                                onPageChanged: (index){
                                  print(index);
                                  _favFoldersViewModel.setNoPage(index);
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                  if(widget.page == "wardrobe"){
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
                                    onTap: (){
                                      if(widget.page == "wardrobe"){
                                        _favFoldersViewModel.dressMeImagesList(
                                          userId: userId,
                                          email: email,
                                          ip: ip,
                                        );
                                      }else {
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
    this.folderId="",
  });

  @override
  State<FavImagesGridView> createState() => _FavImagesGridViewState();
}

class _FavImagesGridViewState extends State<FavImagesGridView> {
  final String email = AuthLocalDataSource.getEmail();
  final String ip = AuthLocalDataSource.getIp();
  final String userId = AuthLocalDataSource.getUserid();
  ProductsViewModel productsViewModel = ProductsViewModel();
  @override
  Widget build(BuildContext context) {
    Future<void> _share(int id) async {
    await Share.share("https://stylorita.com/post_preview_evening.php?id=$id");
  }
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 30.0,
        top: 8.0,
      ),
      sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
            childCount: widget.productListData!.length,
            (context, index) {
              return GestureDetector(
            onTap: (){
              print(index);
              AppNavigation.to(context, DressDetailPage(
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
                if(widget.page == "wardrobe"){
                  widget.favFoldersViewModel.dressMeImagesList(
                    email: email,
                    ip: ip,
                    userId: userId,
                  );
                }else {
                  widget.favFoldersViewModel.favFolderImagesList(
                    folderId: widget.folderId,
                    email: email,
                    ip: ip,
                  );
                }
             });
            },
            child: GridTile(
              footer: GridTileBar(
                leading: GestureDetector(
                  onTap: () => _share(widget.productListData![index].uid!),
                  child: const Icon(
                    Icons.share,
                    color: AppColors.blackColor,
                  ),
                ),
                title: const Text(""),
                trailing: GestureDetector(
                  onTap: (){
                    print(widget.favFoldersViewModel.favouriteList);
                    if(widget.favFoldersViewModel.favouriteList.contains(index)){
                      widget.favFoldersViewModel.removeFromFavourite(index);
                      widget.favFoldersViewModel.decrementFromFavourite(index);
                      productsViewModel.unLikeImageById(
                        email: email,
                        ip: ip,
                        id: widget.productListData![index].uid!.toString()
                      );
                    }else {
                      widget.favFoldersViewModel.addFromFavourite(index);
                      widget.favFoldersViewModel.incrementFromFavourite(index);
                      productsViewModel.likeImageById(
                        email: email,
                        ip: ip,
                        id: widget.productListData![index].uid!.toString()
                      );
                    }
                    setState(() {});
                  },
                  child: Icon(widget.favFoldersViewModel.favouriteList.contains(index)
                        ? Icons.favorite
                        : Icons.favorite_border,
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
          );
            }), 
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 226,
              crossAxisSpacing: 15,
              mainAxisSpacing: 16,
            ),
      ),
    );
  }
}

class EmptyFavImagesFolder extends StatefulWidget {
  const EmptyFavImagesFolder({super.key});

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
            child: Text(AppLocalization.of(context)!.getTranslatedValues("youdidntaddimage")!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        Image.asset(AppAssets.folderDetail)
      ]),
    );
  }
}
