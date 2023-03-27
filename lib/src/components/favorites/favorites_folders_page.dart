import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/favorite_detail/favorite_detail_page.dart';
import 'package:outfit/src/components/favorites/modals/add_folder_dialog.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';

class FavoritesFolderPage extends StatefulWidget {
  const FavoritesFolderPage({Key? key}) : super(key: key);

  @override
  State<FavoritesFolderPage> createState() => _FavoritesFolderPageState();
}

class _FavoritesFolderPageState extends State<FavoritesFolderPage> {
  final _favorites = [
    FavModel(title: 'My Favourites'),
    FavModel(title: 'My Photos'),
  ];

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
          const FavPageTitleWidget(),
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
                  Expanded(
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
                                  _favorites.add(FavModel(title: _));
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
                                            _favorites.add(FavModel(title: _));
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
                                    Text(
                                      'Create a new folder',
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
                        final fav = _favorites[i - 1];
                        return GestureDetector(
                          onTap: () {
                            AppNavigation.to(
                              context,
                              const FavoriteDetailPage(),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: _shadow,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
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
                                              _favorites.add(
                                                FavModel(title: _),
                                              );
                                              setState(() {});
                                            },
                                          ).show(context);
                                        } else {
                                          _favorites.removeAt(i - 1);
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
                                              Text(
                                                'Edit',
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
                                              Text(
                                                'Delete',
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
                                Image.asset(fav.icon, width: 35, height: 30),
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
                                Text(
                                  fav.title,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: const Color(0xFF424242),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _favorites.length + 1,
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

class FavModel {
  final String title;
  final String icon;

  FavModel({required this.title, this.icon = AppAssets.imagePlaceholder});
}
