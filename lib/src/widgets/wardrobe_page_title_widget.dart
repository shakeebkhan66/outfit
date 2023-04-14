import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';

class WardrobePageTitleWidget extends StatelessWidget {
  const WardrobePageTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 30, right: 29),
      title: RichText(
        text: TextSpan(
          text: 'My ',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Wardrobe',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(AppLocalization.of(context)!.getTranslatedValues("letushelpyoudress")!,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: Colors.white,
        ),
      ),
      trailing: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          color: Color(0xFFE096C6),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '?',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
