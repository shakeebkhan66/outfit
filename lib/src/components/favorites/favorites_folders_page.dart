import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/favorite_detail/favorite_detail_page.dart';
import 'package:outfit/src/components/favorites/modals/add_folder_dialog.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/utils/app_urls.dart';
import 'package:outfit/src/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class FavoritesFolderPage extends StatefulWidget {
  const FavoritesFolderPage({Key? key}) : super(key: key);

  @override
  State<FavoritesFolderPage> createState() => _FavoritesFolderPageState();
}

class _FavoritesFolderPageState extends State<FavoritesFolderPage> {
  final FavFoldersViewModel _favFoldersViewModel = FavFoldersViewModel();
  @override
  void initState() {
    _favFoldersViewModel.favFoldersList();
    super.initState();
  }
  List<BoxShadow> get _shadow => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 9,
          spreadRadius: 0,
          color: Colors.black.withOpacity(0.12),
        ),
      ];

  SliverGridDelegate get _delegate {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 153,
      mainAxisSpacing: 43,
      crossAxisSpacing: 39,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(children: [
          FavPageTitleWidget(
            title: AppLocalization.of(context)!.getTranslatedValues("myfavourites")!,
            onCrossback: (){
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  ChangeNotifierProvider.value(
                    value: _favFoldersViewModel,
                    child: Consumer<FavFoldersViewModel>(
                      builder: (context, value, child) {
                        switch (value.favFolders.status!) {
                          case Status.loading:
                          return const FavFolderShimmerLoader();
                          case Status.error:
                          return const Text("error");
                          case Status.completed:
                          return Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                left: 35,
                                right: 34,
                                top: 98,
                                bottom: 30,
                              ),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: _delegate,
                              itemBuilder: (_, i) {
                                if (i == 0) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await AddFolderDialog(
                                        callback: (_) {
                                          setState(() {});
                                        },
                                      ).show(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryColor,
                                            AppColors.primaryColor.withOpacity(0.5),
                                          ],
                                        ),
                                        boxShadow: _shadow,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            FloatingActionButton(
                                              backgroundColor: AppColors.primaryColor,
                                              onPressed: () async {
                                                await AddFolderDialog(
                                                  callback: (_) {
                                                    setState(() {});
                                                  },
                                                ).show(context);
                                              },
                                              child: const Icon(Icons.add),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                top: 30,
                                                bottom: 16,
                                              ),
                                              child: Divider(
                                                color: Color(0xFFE0DFDF),
                                                thickness: 1,
                                                height: 0,
                                                indent: 4,
                                                endIndent: 5,
                                              ),
                                            ),
                                            Text(AppLocalization.of(context)!.getTranslatedValues("createnewfolder")!,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: const Color(0xFF424242),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final fav = value.favFolders.data!.data![i - 1];
                                return GestureDetector(
                                  onTap: () {
                                    AppNavigation.to(
                                      context,
                                      FavoriteDetailPage(
                                        folderName: fav.list_name!,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: _shadow,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if(fav.first_image == null || fav.first_image!.photo==null)
                                            Image.asset(AppAssets.imagePlaceholder, width: 35, height: 30)
                                            else
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(5.0),
                                              child: Image.network( AppUrl.webUrl + fav.first_image!.photo!.url!,
                                                width: 50.0,
                                                height: 60.0,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                top: 28,
                                                bottom: 13,
                                              ),
                                              child: Divider(
                                                color: Color(0xFFE0DFDF),
                                                thickness: 1,
                                                height: 0,
                                                indent: 4,
                                                endIndent: 5,
                                              ),
                                            ),
                                            Text(fav.list_name!,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: const Color(0xFF424242),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 11,
                                              right: 11,
                                              bottom: 12,
                                            ),
                                            child: PopupMenuButton<int>(
                                              color: Colors.white,
                                              offset: i.isEven
                                                  ? const Offset(-100, 18)
                                                  : const Offset(-10, 18),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.zero,
                                                  bottomLeft: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                              ),
                                              onSelected: (_) async {
                                                if (_ == 0) {
                                                  await AddFolderDialog(
                                                    callback: (_) {
                                                        _favFoldersViewModel.updateFolderName(
                                                          fav.id.toString(), UpdateFolderData(
                                                            user: "2906",
                                                            description: "des",
                                                            type: "outfit",
                                                            list_name: _,
                                                          ),
                                                        );
                                                      setState(() {});
                                                    },
                                                  ).show(context);
                                                } else {
                                                  _favFoldersViewModel.deleteFolder(fav.id.toString());
                                                  setState(() {});
                                                }
                                              },
                                              itemBuilder: (_) {
                                                return [
                                                  PopupMenuItem<int>(
                                                    value: 0,
                                                    child: Row(children: [
                                                      Image.asset(
                                                        AppAssets.editIcon,
                                                        height: 24,
                                                        width: 14.17,
                                                      ),
                                                      const SizedBox(width: 9.42),
                                                      Text(AppLocalization.of(context)!.getTranslatedValues("eidt")!,
                                                        style: GoogleFonts.montserrat(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 1,
                                                    child: Row(children: [
                                                      Image.asset(
                                                        AppAssets.deleteIcon,
                                                        width: 14.17,
                                                        height: 11.33,
                                                      ),
                                                      const SizedBox(width: 9.42),
                                                      Text(AppLocalization.of(context)!.getTranslatedValues("delete")!,
                                                        style: GoogleFonts.montserrat(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ];
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: _favFoldersViewModel.favFolders.data!.data!.length + 1,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
