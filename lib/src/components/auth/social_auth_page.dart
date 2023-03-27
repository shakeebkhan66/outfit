import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/home/home_page.dart';

class SocialAuthPage extends StatefulWidget {
  const SocialAuthPage({Key? key}) : super(key: key);

  @override
  State<SocialAuthPage> createState() => _SocialAuthPageState();
}

class _SocialAuthPageState extends State<SocialAuthPage> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        margin: EdgeInsets.only(top: padding.top + 70),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              Image.asset(
                AppAssets.auth,
                width: 240,
                height: 240,
                opacity: const AlwaysStoppedAnimation(.6),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, bottom: 30),
                child: Text(
                  'Login With',
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _AuthButtonWidget(
                onTap: () {
                  AppNavigation.navigateRemoveUntil(
                    context,
                    const HomePage(),
                  );
                },
                title: 'Google',
                icon: Image.asset(
                  AppAssets.google,
                  width: 19,
                  height: 19,
                ),
                gap: 13.46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _AuthButtonWidget(
                  onTap: () {
                    AppNavigation.navigateRemoveUntil(
                      context,
                      const HomePage(),
                    );
                  },
                  title: 'Facebook',
                  icon: Image.asset(
                    AppAssets.facebook,
                    width: 20,
                    height: 20,
                  ),
                  gap: 11,
                ),
              ),
              _AuthButtonWidget(
                onTap: () {
                  AppNavigation.navigateRemoveUntil(context, const HomePage());
                },
                title: 'Apple',
                icon: Image.asset(
                  AppAssets.apple,
                  width: 21,
                  height: 21,
                ),
                gap: 18.14,
              ),
              const SizedBox(height: 20),
              _AuthButtonWidget(
                onTap: () {
                  AppNavigation.navigateRemoveUntil(context, const HomePage());
                },
                title: 'Email',
                icon: Image.asset(
                  AppAssets.email,
                  width: 18,
                  height: 18,
                ),
                gap: 13,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatefulWidget {
  const _AuthButtonWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.gap,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Widget icon;
  final double gap;

  @override
  State<_AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<_AuthButtonWidget> {
  var _isButtonTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        _isButtonTapped = true;
        setState(() {});
      },
      onLongPressEnd: (_) {
        _isButtonTapped = false;
        setState(() {});
      },
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFBE7F3),
          surfaceTintColor: const Color(0xFFFBE7F3),
          backgroundColor:
              _isButtonTapped ? const Color(0xFFFBE7F3) : Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: AppColors.primaryColor, width: 1),
          ),
        ),
        onPressed: widget.onTap,
        child: Row(children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: widget.gap),
              child: Align(
                alignment: Alignment.centerRight,
                child: widget.icon,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              widget.title,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isButtonTapped
                    ? AppColors.primaryColor
                    : const Color(0xFF565656),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
