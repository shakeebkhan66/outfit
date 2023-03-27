import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/home/views/outfit_ideas_view.dart';
import 'package:outfit/src/widgets/radio_button_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
    required this.style,
    required this.hijab,
    required this.season,
    required this.callback,
  }) : super(key: key);

  final Styles style;
  final Hijab hijab;
  final Seasons season;
  final void Function(Styles, Hijab, Seasons) callback;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Styles _style;
  late Hijab _hijab;
  late Seasons _season;

  @override
  void initState() {
    _style = widget.style;
    _hijab = widget.hijab;
    _season = widget.season;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _style = widget.style;
    _hijab = widget.hijab;
    _season = widget.season;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: 40,
            bottom: padding.bottom + 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle('Style'),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 22, top: 8),
                child: AppRadioGroup<Styles>(
                  groupController: RadioWidgetController(
                    value: _style,
                    items: Styles.values,
                    onChanged: (_) {
                      _style = _;
                      widget.callback(_style, _hijab, _season);
                    },
                  ),
                ),
              ),
              _getDivider(),
              _getTitle('Hijab'),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 22, top: 8),
                child: AppRadioGroup<Hijab>(
                  groupController: RadioWidgetController(
                    value: _hijab,
                    items: Hijab.values,
                    onChanged: (_) {
                      _hijab = _;
                      widget.callback(_style, _hijab, _season);
                    },
                  ),
                ),
              ),
              _getDivider(),
              _getTitle('Season'),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 22, top: 8),
                child: AppRadioGroup<Seasons>(
                  groupController: RadioWidgetController(
                    value: _season,
                    items: Seasons.values,
                    onChanged: (_) {
                      _season = _;
                      widget.callback(_style, _hijab, _season);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      minimumSize: const Size(115, 42),
                    ),
                    onPressed: () => AppNavigation.pop(context),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFBF9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _getDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        color: Color(0xFF8C8C8C),
        thickness: 1,
        height: 0,
        endIndent: 32,
        indent: 32,
      ),
    );
  }
}
