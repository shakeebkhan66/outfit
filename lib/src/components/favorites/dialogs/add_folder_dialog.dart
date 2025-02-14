import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:reusables/mixins/form_state_mixin.dart';
import 'package:reusables/reusables.dart';

class AddFolderDialog extends StatefulWidget {
  final String title;
  const AddFolderDialog({Key? key, required this.callback, required this.title}) : super(key: key);

  final void Function(String) callback;

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: false,
    );
  }

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> with FormStateMixin {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 27),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 9),
                child: Text(
                  AppLocalization.of(context)!.getTranslatedValues("foldername")!,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                ),
              ),
              TextFormField(
                validator: InputValidator.required(
                  message: 'Folder name is required',
                ),
                controller: _folderNameController,
                decoration: InputDecoration(
                  border: _border,
                  enabledBorder: _border,
                  focusedBorder: _border,
                ),
              ),
              const SizedBox(height: 26),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEE3E38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => AppNavigation.pop(context),
                    child: _getButtonTitle(AppLocalization.of(context)!.getTranslatedValues("close")!),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF319D97,
                      ).withOpacity(0.7126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: submitter,
                    child: _getButtonTitle(AppLocalization.of(context)!.getTranslatedValues("done")!),
                  ),
                ),
              ]),
            ],
          ),
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
  Future<void> onSubmit() async {
    widget.callback(_folderNameController.text);
    AppNavigation.pop(context);
  }
}

class DeleteFolderDialog extends StatefulWidget {
  const DeleteFolderDialog({Key? key, required this.callback}) : super(key: key);

  final void Function(String) callback;

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: false,
    );
  }

  @override
  State<DeleteFolderDialog> createState() => _DeleteFolderDialogState();
}

class _DeleteFolderDialogState extends State<DeleteFolderDialog> with FormStateMixin {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 27),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalization.of(context)!.getTranslatedValues("deletefolder")!,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalization.of(context)!.getTranslatedValues("suredelete")!,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEE3E38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => AppNavigation.pop(context),
                    child: _getButtonTitle(AppLocalization.of(context)!.getTranslatedValues("close")!),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF319D97,
                      ).withOpacity(0.7126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: submitter,
                    child: _getButtonTitle(AppLocalization.of(context)!.getTranslatedValues("delete")!),
                  ),
                ),
              ]),
            ],
          ),
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
  Future<void> onSubmit() async {
    widget.callback(_folderNameController.text);
    AppNavigation.pop(context);
  }
}
