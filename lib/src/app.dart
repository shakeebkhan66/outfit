import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outfit/app_localization.dart';
import 'package:outfit/src/components/home/home_page.dart';
import 'package:outfit/src/components/language/language_selection_page.dart';
import 'package:outfit/src/data/repository/auth_local_data_repo.dart';
import 'package:outfit/src/data/view_model/auth_view_model.dart';
import 'package:outfit/src/data/view_model/colors_view_model.dart';
import 'package:outfit/src/data/view_model/favourites_view_model.dart';
import 'package:outfit/src/data/view_model/photos_view_model.dart';
import 'package:outfit/src/data/view_model/wardrobe_view_model.dart';
import 'package:outfit/src/providers/filter_pair_provider.dart';
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
    await Firebase.initializeApp();
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
    await Hive.openBox(authBox); 
    await Hive.openBox(langBox); 
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> LanguageProvider(SettingsLocalDataSource())),
          ChangeNotifierProvider(create: (_)=> AuthViewModel()),
          ChangeNotifierProvider(create: (_)=> FilterPairProvider()),
          ChangeNotifierProvider(create: (_)=> WardrobeViewModel()),
          ChangeNotifierProvider(create: (_)=> ProductsViewModel()),
          ChangeNotifierProvider(create: (_)=> ColorsAndStylesViewModel()),
          ChangeNotifierProvider(create: (_)=> FavFoldersViewModel()),
        ],
        child: const MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = Provider.of<LanguageProvider>(context).getAppLanguage;
    final String id = AuthLocalDataSource.getUserid();
    final bool lang = AuthLocalDataSource.getLang();

    return MaterialApp(
      title: 'Outfit',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
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
      home: 
      id == "" && lang == false ?  
      const LanguageSelectionPage() : 
      const HomePage(),
    );
  }
}
