import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';

class DressDetailPage extends StatelessWidget {
  const DressDetailPage({Key? key, required this.dress}) : super(key: key);

  final String dress;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(27, 22, 0, 11.5),
                child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
              child: Column(children: [
                Image.asset(
                  AppAssets.productDetail,
                  height: 460,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 16, 31, 90),
                  child: Row(children: [
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFFF2C2C),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '1024 likes',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.share,
                      color: AppColors.blackColor,
                    ),
                    const SizedBox(width: 19.5),
                    const Icon(Icons.bookmark_border, size: 26),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.fromLTRB(42.5, 15.67, 44.17, 15.67),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'Source',
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8C8C8C),
                      ),
                    ),
                    const SizedBox(width: 9.67),
                    Image.asset(AppAssets.instagram, height: 16.67, width: 16.67),
                  ]),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
