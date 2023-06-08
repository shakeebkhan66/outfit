import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/data/model/password_model.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/view_model/auth_view_model.dart';
import 'package:outfit/src/utils/form_validator.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final String email = AuthLocalDataSource.getEmail();
  final String username = AuthLocalDataSource.getUserName();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!.getTranslatedValues("profilesettings")!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsListTile(
                    title: "username",
                    subTitle: username,
                  ),
                  SettingsListTile(
                    title: "email",
                    subTitle: email,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SettingsListTile(
                        title: "password",
                        subTitle: "••••••••",
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: AppButtonWidget(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          buttonRadius: 5.0,
                          title: "change",
                          titleSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  isExpanded
                      ? PasswordCard(
                          onClose: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        )
                      : Container(),
                  AccountDeletionTile(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogcontext) {
                          return AccountDelDialog(
                            onDelete: () {
                              Navigator.of(dialogcontext).pop();
                              authViewModel.accountDelApi(email, context);
                            },
                          );
                        },
                      );
                    },
                    title: "Account Deletion",
                    subTitle: "ifyoudelete",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsColors {
  static Color lightGrey = const Color(0xFF717479);
}

class SettingsListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const SettingsListTile({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context)!.getTranslatedValues(title)!,
          style: TextStyle(
            fontSize: 18.0,
            color: SettingsColors.lightGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const Divider(
          thickness: 1.3,
        ),
      ],
    );
  }
}

class PasswordCard extends StatefulWidget {
  final VoidCallback onClose;
  const PasswordCard({super.key, required this.onClose});

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final String email = AuthLocalDataSource.getEmail();
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          color: const Color(0xFFF8F8F8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 12.0),
                  child: Text(
                    AppLocalization.of(context)!.getTranslatedValues("changepassowrd")!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.3,
                ),
                PasswordListTile(
                  controller: currentPasswordController,
                  content: "currentpassword",
                  validator: (password) => FormValidator.passwordValidator(password, context),
                ),
                PasswordListTile(
                  controller: newPasswordController,
                  validator: (password) => FormValidator.passwordValidator(password, context),
                  content: "newpassword",
                ),
                PasswordListTile(
                  controller: retypePasswordController,
                  validator: (password) => FormValidator.confirmPasswordValidator(
                    firstPassword: newPasswordController.text,
                    confirmPassword: password,
                  ),
                  content: "confirmnewpasword",
                ),
                PasswordButtons(
                  onChangePressed: () {
                    if (formKey.currentState!.validate()) {
                      authViewModel.passwordUpdateApi(
                          PasswordModel(
                            email: email,
                            current_password: currentPasswordController.text,
                            password: newPasswordController.text,
                            password_confirmation: retypePasswordController.text,
                          ),
                          context);
                    }
                  },
                  onClosePressed: widget.onClose,
                ),
              ],
            ),
          ),
        ),
        authViewModel.passwordLoading
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : Container(),
      ],
    );
  }
}

class PasswordListTile extends StatelessWidget {
  final TextEditingController controller;
  final String content;
  final String? Function(String? value)? validator;
  const PasswordListTile({
    super.key,
    required this.controller,
    required this.content,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            AppLocalization.of(context)!.getTranslatedValues(content)!,
            style: const TextStyle(
              color: Color(0xFF2E313E),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ProfilePasswordTextField(
            validator: validator,
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class ProfilePasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  const ProfilePasswordTextField({super.key, required this.controller, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        filled: true,
      ),
    );
  }
}

class PasswordButtons extends StatelessWidget {
  final VoidCallback onChangePressed;
  final VoidCallback onClosePressed;
  const PasswordButtons({
    super.key,
    required this.onChangePressed,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 160,
            child: AppButtonWidget(
              onTap: onChangePressed,
              buttonRadius: 5.0,
              title: "changepassowrd",
              titleSize: 13.0,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: AppButtonWidget(
              onTap: onClosePressed,
              buttonRadius: 5.0,
              title: "close",
              color: Colors.grey,
              titleSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountDeletionTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  const AccountDeletionTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1.3,
        ),
        Text(
          AppLocalization.of(context)!.getTranslatedValues(title)!,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppLocalization.of(context)!.getTranslatedValues(subTitle)!,
          style: const TextStyle(
            fontSize: 12.0,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        authViewModel.accountDelLoading
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : SizedBox(
                height: 40,
                width: 160,
                child: AppButtonWidget(
                  onTap: onPressed,
                  buttonRadius: 5.0,
                  title: "deleteaccount",
                  color: Colors.redAccent,
                  titleSize: 16.0,
                ),
              ),
      ],
    );
  }
}

class AccountDelDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const AccountDelDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalization.of(context)!.getTranslatedValues("Account Deletion")!),
      content: Text(AppLocalization.of(context)!.getTranslatedValues("ifyoudelete")!),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalization.of(context)!.getTranslatedValues("close")!,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ),
        TextButton(
          onPressed: onDelete,
          child: Text(
            AppLocalization.of(context)!.getTranslatedValues("deleteaccount")!,
            style: const TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
