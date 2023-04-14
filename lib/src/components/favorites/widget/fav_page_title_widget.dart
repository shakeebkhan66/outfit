import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavPageTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onCrossback;
  const FavPageTitleWidget({Key? key, required this.onCrossback, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44, bottom: 40),
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
        Positioned(
          left: 27,
          child: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: _containerWidget(
              const Icon(Icons.arrow_back_ios_new, color: Colors.white,size: 16.0),
            ),
          ),
        ),
        Center(
          child: Text(title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          right: 27,
          child: GestureDetector(
            onTap: onCrossback,
            child: _containerWidget(
              const Icon(Icons.close, color: Colors.white, size: 16.0),
            ),
          ),
        )
      ]),
    );
  }

  Widget _containerWidget(Widget child) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: Color(0xFFE096C6),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
