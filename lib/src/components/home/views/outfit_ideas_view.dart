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
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/widgets/custom_webview_drawer.dart';
import 'package:outfit/src/widgets/pagination.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class OutfitIdeasView extends StatefulWidget {
  final ProductsViewModel productViewModel;
  const OutfitIdeasView({Key? key, required this.productViewModel}) : super(key: key);

  @override
  State<OutfitIdeasView> createState() => _OutfitIdeasViewState();
}

class _OutfitIdeasViewState extends State<OutfitIdeasView> {
  final _scrollController = ScrollController();
  final String email = AuthLocalDataSource.getEmail();
  final String ip = AuthLocalDataSource.getIp();
  @override
  void initState() {
    widget.productViewModel.fetchPhotosList(
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
    final filterPairProvider = Provider.of<FilterPairProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      endDrawer: DrawerWidget(
        hijab: hijab,
        style: style,
        season: season,
        updateList: (d){
        },
        callback: (newStyle, newHijab, newSeason) {
          hijab = newHijab;
          season = newSeason;
          style = newStyle;
        },
        productsViewModel: widget.productViewModel,
      ),
      drawer: const WebDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if(email == ""){
              AppNavigation.to(context, const SocialAuthPage());
            }else {
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
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
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
              padding: const EdgeInsets.fromLTRB(16, 27.8, 16, 0),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: (){
                    AppNavigation.to(context, SearchPage(
                      productsViewModel: widget.productViewModel,
                    ));
                  },
                  child: TextFormField(
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    onChanged: (_) {
                    },
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
                      suffixIcon:
                          const Icon(Icons.search, color: Color(0xFF8C8C8C)),
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
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalization.of(context)!.getTranslatedValues("trendydress")!,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                    ),
                    if(widget.productViewModel.getPageName == "search")
                    Container()
                    else
                    GestureDetector(
                      onTap: () => scaffoldKey.currentState!.openEndDrawer(),
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
                          Text(AppLocalization.of(context)!.getTranslatedValues("filter")!,
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
                                AppNavigation.to(context, DressDetailPage(
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
                                if(widget.productViewModel.getPageName == "search"){
                                  widget.productViewModel.fetchFilterPairList(
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
                                } else if(widget.productViewModel.getPageName == "filter"){
                                  widget.productViewModel.filterPhotoPhotosList(
                                    email: email,
                                    ip: ip,
                                  );
                                }
                                else{
                                  widget.productViewModel.fetchPhotosList(
                                    email: email,
                                    ip: ip,
                                  );
                                }
                                });
                              },
                              child: GridTile(
                                footer: GridTileBar(
                                  leading: GestureDetector(
                                    onTap: () => _share(products[i].uid!),
                                    child: const Icon(
                                      Icons.share,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  title: const Text(""),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      if(widget.productViewModel.favouriteList.contains(i)){
                                        widget.productViewModel.removeFromFavourite(i);
                                        widget.productViewModel.decrementFromFavourite(i);
                                        widget.productViewModel.unLikeImageById(
                                          email: email,
                                          ip: ip,
                                          id: products[i].uid!.toString()
                                        );
                                      }else {
                                        widget.productViewModel.addFromFavourite(i);
                                        widget.productViewModel.incrementFromFavourite(i);
                                        widget.productViewModel.likeImageById(
                                          email: email,
                                          ip: ip,
                                          id: products[i].uid!.toString()
                                        );
                                      }
                                    },
                                    child: Icon(widget.productViewModel.favouriteList.contains(i)
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
                     return const CustomShimmerLoader(itemCount: 10,);
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 108,
                ),
                child: Pagination(
                  numOfPages: widget.productViewModel.getTotalPages, 
                  selectedPage: widget.productViewModel.getPage, 
                  pagesVisible: 14, 
                  onPageChanged: (index){
                    print(index);
                    widget.productViewModel.setNoPage(index);
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    if(widget.productViewModel.getCurrentPage == Pages.products){
                      widget.productViewModel.setPage("outfit");
                      widget.productViewModel.fetchPhotosList(
                        email: email,
                        ip: ip,
                      );
                    }else if(widget.productViewModel.getCurrentPage == Pages.filter){
                      widget.productViewModel.setPage("filter");
                      widget.productViewModel.filterPhotoPhotosList(
                        email: email,
                        ip: ip,
                      );
                    }else if(widget.productViewModel.getCurrentPage == Pages.search){
                      widget.productViewModel.setPage("search");
                      widget.productViewModel.fetchFilterPairList(
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

  Future<void> _share(int id) async {
    await Share.share("https://stylorita.com/post_preview_evening.php?id=$id");
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
