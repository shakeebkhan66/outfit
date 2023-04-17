import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/login_pages/login_page.dart';
import 'package:outfit/src/data/model/user_model.dart';
import 'package:outfit/src/data/view_model/auth_view_model.dart';
import 'package:outfit/src/utils/form_validator.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
import 'package:outfit/src/widgets/custom_loader.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!
                        .getTranslatedValues('createanaccount')!,
          style: const TextStyle(
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20.0),
                CustomTextField(
                  prefixIcon: Icons.person,
                  controller: _firstNameController,
                  hintText: 'firstname',
                  validator: FormValidator.nameValidator,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  prefixIcon: Icons.person,
                  controller: _lastNameController,
                  hintText: 'lastname',
                  validator: FormValidator.lastnameValidator,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  validator: FormValidator.emailValidator,
                  hintText: 'email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  validator: FormValidator.passwordValidator,
                  hintText: 'password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 40.0),
                authViewModel.signUpLoading ? 
                const CustomLoader() : 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: AppButtonWidget(
                    onTap: () {
                      if(formKey.currentState!.validate()){
                        authViewModel.signUpApi(UserModel(
                          first_name: _firstNameController.text,
                          last_name: _lastNameController.text,
                          email: _emailController.text,
                          type: 'user',
                          authProvider: AuthProvider.email,
                          password: _passwordController.text,
                        ), context);
                      }
                    },
                    title: 'register',
                    buttonRadius: 15,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(AppLocalization.of(context)!
                          .getTranslatedValues('or')!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialAuthButton(
                      image: AppAssets.google, 
                      onPressed: (){},
                    ),
                    SocialAuthButton(
                      image: AppAssets.facebook, 
                      onPressed: (){},
                    ),
                    if(Platform.isAndroid)
                    Container()
                    else
                    SocialAuthButton(
                      image: AppAssets.apple, 
                      onPressed: (){},
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalization.of(context)!
                          .getTranslatedValues('alreadyhaveaccount')!),
                    TextButton(
                      onPressed: () {
                        AppNavigation.to(context, LoginPage());
                      },
                      child: Text(AppLocalization.of(context)!
                          .getTranslatedValues('login')!,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData prefixIcon;
  final String? Function(String? value)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    required this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;
  bool get isPasswordField =>
      widget.keyboardType == TextInputType.visiblePassword;
   void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: AppLocalization.of(context)!.getTranslatedValues(widget.hintText)!,
        filled: true,
        isDense: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(widget.prefixIcon,color: AppColors.primaryColor,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.0,
            ),
          ),
        suffixIcon: isPasswordField
          ? InkWell(
              onTap: _togglePasswordVisibility,
              child: Icon(hidePassword ?
                Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryColor,
                size: 22,
              ),
            )
          : null,
        ),
        keyboardType: widget.keyboardType,
        obscureText: isPasswordField && hidePassword,
      );
  }
}

class SocialAuthButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  const SocialAuthButton({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
        onPressed: onPressed, 
        icon: Image.asset(image),
      ),
    );
  }
}