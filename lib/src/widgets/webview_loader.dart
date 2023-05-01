import 'package:flutter/material.dart';
import 'package:outfit/src/base/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String info;
  final String title;

  const WebViewPage({
    super.key,
    required this.url,
    required this.info,
    required this.title,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final double _progressValue = 0.0;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
            if (progress > 20) {
              if (widget.info == "enHijab") {
                controller.runJavaScriptReturningResult(
                    "document.getElementsByClassName('rmp_menu_trigger rmp-menu-trigger-boring')[0].style.display='none'");
                controller.runJavaScriptReturningResult("document.getElementsByTagName('header')[0].style.display='none'");
              } else if (widget.info == "enStyle") {
                controller.runJavaScriptReturningResult("document.getElementsByClassName('td-header-template-wrap')[0].style.display='none'");
              } else if (widget.info == "arHijab") {
                controller.runJavaScriptReturningResult(
                    "document.getElementsByClassName('rmp_menu_trigger rmp-menu-trigger-boring')[0].style.display='none'");
                controller.runJavaScriptReturningResult("document.getElementsByClassName('container-fluid')[0].style.display='none'");
              } else if (widget.info == "arStyle") {
                controller.runJavaScriptReturningResult(
                    "document.getElementsByClassName('rmp_menu_trigger rmp-menu-trigger-boring')[0].style.display='none'");
                controller.runJavaScriptReturningResult("document.getElementsByClassName('fluid_container new-header')[0].style.display='none'");
              }
            }
            print(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
