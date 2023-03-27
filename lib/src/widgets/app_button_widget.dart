import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/theme.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    Key? key,
    required this.onTap,
    required this.title,
    this.titleSize = 19,
    this.buttonSize = const Size.fromHeight(56),
    this.buttonRadius = 11,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final double titleSize;
  final Size buttonSize;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(buttonRadius),
        boxShadow: AppShadow.primaryShadow,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: buttonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: titleSize,
          ),
        ),
      ),
    );
  }
}
