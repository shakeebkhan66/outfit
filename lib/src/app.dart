import 'package:flutter/material.dart';
import 'package:outfit/src/components/language/language_selection_page.dart';

import 'base/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit',
      theme: AppTheme.lightTheme,
      home: const LanguageSelectionPage(),
    );
  }
}
