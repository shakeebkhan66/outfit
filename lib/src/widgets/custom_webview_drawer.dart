import 'package:flutter/material.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/components/favorites/dialogs/change_language_dialog.dart';
import 'package:outfit/src/components/home/home_page.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/widgets/webview_loader.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = AuthLocalDataSource.getUserid();
    final padding = MediaQuery.of(context).padding;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  AppNavigation.to(context,
                      const WebViewPage(url: "https://stylorita.com/instyle/"));
                },
                title: Text(AppLocalization.of(context)!
                    .getTranslatedValues("stylelesson")!),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: () {
                  AppNavigation.to(
                      context,
                      const WebViewPage(
                          url: "https://www.stylorita.com/hijab-tutorials/"));
                },
                title: Text(AppLocalization.of(context)!
                    .getTranslatedValues("hijabtutorial")!),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: () async {
                  await ChangeLanguageDialog(
                    callback: (_) {},
                  ).show(context);
                },
                title: Text(AppLocalization.of(context)!
                    .getTranslatedValues("changelanguge")!),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: () async {
                  if (id == "") {
                    AppNavigation.to(context, const SocialAuthPage());
                  } else {
                    await AuthLocalDataSource.clearData();
                    AppNavigation.navigateRemoveUntil(
                        context, const HomePage());
                  }
                },
                title: Text(id == ""
                    ? AppLocalization.of(context)!.getTranslatedValues("login")!
                    : AppLocalization.of(context)!
                        .getTranslatedValues("logout")!),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
