import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/components/search/widget/color_style_widget.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 17),
            child: Row(children: [
              _containerWidget(
                Text(
                  '?',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Let us help you dress like\na Fashionista!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => AppNavigation.pop(context),
                child: _containerWidget(
                  const Icon(Icons.close, color: Colors.white, size: 17),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                physics: const BouncingScrollPhysics(),
                child: Column(children: const [
                  SizedBox(height: 37),
                  ColorStyleWidget(),
                ]),
              ),
            ),
          ),
        ]),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 32),
        child: AppButtonWidget(
          onTap: () => AppNavigation.pop(context),
          title: 'Search',
        ),
      ),
    );
  }

  Widget _containerWidget(Widget child) {
    return Container(
      height: 25,
      width: 25,
      decoration: const BoxDecoration(
        color: Color(0xFFE096C6),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

enum SearchStyle {
  trousers('Trousers'),
  shirts('Shirts'),
  tops('Tops (sweater-blouse-t shirt....)'),
  skirts('Skirts'),
  dressJumpsuitAbaya('Dress-Jumpsuit-Abaya'),
  jacketCoat('Jacket Coat');

  final String value;

  const SearchStyle(this.value);
}
