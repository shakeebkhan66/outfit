import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.person,
                controller: _firstNameController,
                hintText: 'firstname',
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.person,
                controller: _lastNameController,
                hintText: 'lastname',
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.email,
                controller: _emailController,
                hintText: 'email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                prefixIcon: Icons.lock,
                controller: _passwordController,
                hintText: 'password',
                obscureText: true,
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppButtonWidget(
                  onTap: () {
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
                      // navigate to login page
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
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData prefixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: AppLocalization.of(context)!.getTranslatedValues(hintText)!,
        filled: true,
        isDense: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(prefixIcon,color: AppColors.primaryColor,),
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
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
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