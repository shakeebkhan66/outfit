import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/favorites/widget/fav_page_title_widget.dart';

class FavoriteDetailPage extends StatefulWidget {
  const FavoriteDetailPage({Key? key}) : super(key: key);

  @override
  State<FavoriteDetailPage> createState() => _FavoriteDetailPageState();
}

class _FavoriteDetailPageState extends State<FavoriteDetailPage> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(
          children: [
            const FavPageTitleWidget(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
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
                          'You didn’t add any image to this folder.',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
