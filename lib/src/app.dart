import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/components/language/language_selection_page.dart';
import 'package:outfit/src/providers/language_provider.dart';
import 'package:outfit/src/services/local_storage_service.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'base/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> LanguageProvider(SettingsLocalDataSource()))
        ],
        child: const MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    return MaterialApp(
      title: 'Outfit',
      theme: AppTheme.lightTheme,
      locale: currentLanguage,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supporatedLocales.map((languageCode) {
        return AppUtils.getLocaleFromLanguageCode(languageCode);
      }).toList(),
      home: const LanguageSelectionPage(),
    );
  }
}
