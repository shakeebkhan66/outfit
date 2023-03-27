import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/theme.dart';

class ContainerTitleWidget extends StatelessWidget {
  const ContainerTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: RichText(
          text: TextSpan(
            text: 'Show us ',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'your Clothes',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Text(
          'Click on tab to add color and no. of item',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    ]);
  }
}
