
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';
import 'package:outfit/src/components/home/dress_detail/dress_detail_page.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/widgets/get_likes_count.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteDetailPage extends StatefulWidget {
  const FavoriteDetailPage({Key? key}) : super(key: key);

  @override
  State<FavoriteDetailPage> createState() => _FavoriteDetailPageState();
}

class _FavoriteDetailPageState extends State<FavoriteDetailPage> {
  final FavFoldersViewModel _favFoldersViewModel = FavFoldersViewModel();
  @override
  void initState() {
    _favFoldersViewModel.favFolderImagesList();
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
              onCrossback: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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
                        return FavImagesGridView(
                          productListData: value.favFoldersImages.data!.data!.data!,
                        );
                        case Status.error:
                        return const Text("");
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


class FavImagesGridView extends StatelessWidget {
  final List<ProductsData>? productListData;
  const FavImagesGridView({
    super.key,
    required this.productListData,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> _share(String file) async {
      await Share.share('Check out this new and Nice Dress');
    }
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 226,
          crossAxisSpacing: 15,
          mainAxisSpacing: 16,
        ),
      children: List.generate(productListData!.length, (index) {
        return GestureDetector(
          onTap: (){
            AppNavigation.to(context, DressDetailPage(dress: AppUrl.webUrl + productListData![index].url!));
          },
          child: GridTile(
            footer: GridTileBar(
              leading: GestureDetector(
                onTap: () => _share(""),
                child: const Icon(
                  Icons.share,
                ),
              ),
              title: productListData![index].likes != null ?
               CustomText(list: productListData![index].likes) :
               Container(),
              trailing: checkIfLikeExists(
                list: productListData![index].likes,
                email: "nabilmahrous61@gmail.com"
               ) ?
               const Icon(Icons.favorite,color: Colors.red):
               const Icon(Icons.favorite_border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                AppUrl.webUrl + productListData![index].url!,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class EmptyFavImagesFolder extends StatelessWidget {
  const EmptyFavImagesFolder({super.key});

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
