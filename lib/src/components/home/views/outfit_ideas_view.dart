import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/favorites_folders_page.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/components/home/widget/drawer_widget.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class OutfitIdeasView extends StatefulWidget {
  const OutfitIdeasView({Key? key}) : super(key: key);

  @override
  State<OutfitIdeasView> createState() => _OutfitIdeasViewState();
}

class _OutfitIdeasViewState extends State<OutfitIdeasView> {
  final ProductsViewModel _productsViewModel = ProductsViewModel();
  final _scrollController = ScrollController();
  @override
  void initState() {
    _productsViewModel.fetchPhotosList();
    super.initState();
  }
  final _searchFocusNode = FocusNode();
  final _searchController = TextEditingController();
  var season = Seasons.allSeasons;
  var hijab = Hijab.all;
  var style = Styles.allStyle;

  OutlineInputBorder get _inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: Colors.transparent),
      );

  final _favorites = <int>[1, 2, 5, 6, 8, 9];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _allItems = <SearchModel>[
    SearchModel(
      title: 'Tops',
      icon: AppAssets.tops,
      padding: const EdgeInsets.only(left: 7.5, right: 9.5),
    ),
    SearchModel(
      title: 'Jacket',
      icon: AppAssets.jackets,
      padding: const EdgeInsets.only(left: 5, right: 6),
    ),
    SearchModel(
      title: 'Trousers',
      icon: AppAssets.trousers,
      padding: const EdgeInsets.symmetric(vertical: 5),
    ),
    SearchModel(
      title: 'Shirt',
      icon: AppAssets.shirt,
      padding: const EdgeInsets.only(left: 5, right: 13),
    ),
    SearchModel(
      title: 'Trousers',
      icon: AppAssets.trousersTwo,
      padding: const EdgeInsets.only(left: 7, right: 7),
    ),
    SearchModel(
      title: 'Skirt',
      icon: AppAssets.skirt,
      padding: const EdgeInsets.only(left: 7, right: 11),
    ),
  ];

  var _searchedItem = <SearchModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFFFFFFF),
      endDrawer: DrawerWidget(
        hijab: hijab,
        style: style,
        season: season,
        callback: (newStyle, newHijab, newSeason) {
          hijab = newHijab;
          season = newSeason;
          style = newStyle;
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
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
            onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
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
                child: TextFormField(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  onChanged: (_) {
                    if (_.isEmpty) {
                      _searchedItem = _allItems;
                    } else {
                      _searchedItem = _allItems
                          .where((e) => e.title
                              .trim()
                              .toLowerCase()
                              .contains(_.trim().toLowerCase()))
                          .toList();
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for dresses',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: _inputBorder,
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
                    Text(
                      'Trendy dresses',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                    ),
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
                          const Text(
                            'Filter',
                            style: TextStyle(
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
                bottom: 8,
              ),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  alignment: WrapAlignment.start,
                  children: _searchedItem.map((e) {
                    return Container(
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
                        vertical: 8,
                        horizontal: 6,
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Image.asset(e.icon, width: 38, height: 20),
                        const SizedBox(width: 4),
                        Text(
                          e.title,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ]),
                    );
                  }).toList(),
                ),
              ),
            ),
            ChangeNotifierProvider<ProductsViewModel>(
              create: (context)=> _productsViewModel,
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
                                AppNavigation.to(context, DressDetailPage(dress: AppUrl.webUrl + products[i].url!));
                              },
                              child: GridTile(
                                footer: GridTileBar(
                                  leading: GestureDetector(
                                    onTap: () => _share(AppUrl.webUrl + products[i].url!),
                                    child: const Icon(
                                      Icons.share,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  title: const Text(''),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      if (_favorites.contains(i)) {
                                        _favorites.remove(i);
                                      } else {
                                        _favorites.add(i);
                                      }
                                      setState(() {});
                                    },
                                    child: Icon(
                                      _favorites.contains(i)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _favorites.contains(i)
                                          ? const Color(0xFFFF2C2C)
                                          : AppColors.blackColor,
                                    ),
                                  ),
                                ),
                                child: Image.network(AppUrl.webUrl + products[i].url!, fit: BoxFit.fill),
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
            ChangeNotifierProvider<ProductsViewModel>(
              create: (context) => _productsViewModel,
              child: Consumer<ProductsViewModel>(
                builder: (context, value, child) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 108,
                      top: 8,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          if(value.page == 1)
                          Container()
                          else
                          Expanded(
                            child: AppButtonWidget(
                              onTap: (){
                                _productsViewModel.setPreviousPage();
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                _productsViewModel.fetchPhotosList();
                              }, 
                              title: "previouspage",
                              buttonRadius: 5.0,
                              titleSize: 16.0,
                              buttonSize: const Size.fromHeight(20.0),
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            child: AppButtonWidget(
                              onTap: (){
                                _productsViewModel.setNextPage();
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                _productsViewModel.fetchPhotosList();
                              }, 
                              title: "nextpage",
                              titleSize: 18.0,
                              buttonRadius: 5.0,
                              buttonSize: const Size.fromHeight(20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

  Future<void> _share(String file) async {
    await Share.share('Check out this new and Nice Dress');
  }
}

enum Styles {
  allStyle('All styles'),
  trousersOutfits('Trousers outfits'),
  stylesWithSkirts('Styles with skirts'),
  dressesAndJumpsuits('Dresses & jumpsuits');

  final String value;

  const Styles(this.value);
}

enum Hijab {
  all('All'),
  withoutHijab('Without hijab'),
  withHijab('With hijab');

  final String value;

  const Hijab(this.value);
}

enum Seasons {
  allSeasons('All seasons'),
  summerOutfits('Summer outfits'),
  winterOutfits('Winter outfits');

  final String value;

  const Seasons(this.value);
}

class SearchModel {
  final String title;
  final String icon;
  final EdgeInsets padding;

  SearchModel({
    required this.title,
    required this.icon,
    required this.padding,
  });
}
