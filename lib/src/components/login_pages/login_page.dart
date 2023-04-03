import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:outfit/src/components/login_pages/register_page.dart';
import 'package:outfit/src/widgets/app_button_widget.dart';
class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalization.of(context)!
                        .getTranslatedValues('welcomeback')!,
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
                  title: 'login',
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
                        .getTranslatedValues('donthaveaccount')!),
                  TextButton(
                    onPressed: () {
                      // navigate to login page
                    },
                    child: Text(AppLocalization.of(context)!
                        .getTranslatedValues('register')!,
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