import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:provider/provider.dart';

class ChangeLanguageDialog extends StatefulWidget {
  const ChangeLanguageDialog({Key? key, required this.callback}) : super(key: key);

  final void Function(String) callback;

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: false,
    );
  }

  @override
  State<ChangeLanguageDialog> createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  final _folderNameController = TextEditingController();

  InputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change language',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                onTap: (){
                  Provider.of<LanguageProvider>(context,listen: false).changeLanguage(supporatedLocales[0]);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppShadow.primaryShadow,
                  ),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Image.asset(
                        AppAssets.english,
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'English',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                onTap: (){
                  Provider.of<LanguageProvider>(context,listen: false).changeLanguage(supporatedLocales[1]);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppShadow.primaryShadow,
                  ),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Image.asset(
                        AppAssets.arabic,
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Arabic',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButtonTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Future<void> onSubmit(String languageCode) async {
    widget.callback(_folderNameController.text);
    AppNavigation.pop(context);
  }
}
