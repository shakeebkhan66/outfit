import 'package:flutter/material.dart';
import 'package:outfit/src/base/nav.dart';
import 'package:outfit/src/components/auth/social_auth_page.dart';
import 'package:outfit/src/components/favorites/dialogs/change_language_dialog.dart';
import 'package:outfit/src/widgets/webview_loader.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: padding.top),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  AppNavigation.to(context, const WebViewPage(url: "https://stylorita.com/instyle/"));
                },
                title: const Text("Style Lessons"),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: (){
                  AppNavigation.to(context, const WebViewPage(url: "https://www.stylorita.com/hijab-tutorials/"));
                },
                title: const Text("Hijab tutorials"),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: () async {
                  await ChangeLanguageDialog(
                    callback: (_) {
                      
                    },
                  ).show(context);
                },
                title: const Text("Change language"),
                dense: true,
                subtitle: const Divider(
                  height: 1.0,
                ),
              ),
              ListTile(
                onTap: (){
                  AppNavigation.to(context, const SocialAuthPage());
                },
                title: const Text("Logout"),
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