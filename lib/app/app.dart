import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_manager/localization/flutter_localizations_delegate.dart';
import 'package:hotel_manager/route/routes.dart';
import 'package:hotel_manager/screens/splash_screen/splash_screen.dart';
import 'package:hotel_manager/theme/color.dart';


class TravelApp extends StatelessWidget {
  static Router router;
  TravelApp({Key key}):super(key : key){
    final router = Router();
    Routes.configureRoutes(router);
    TravelApp.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.primary,
      supportedLocales: [const Locale('en', 'US'), const Locale('vi', 'VN')],
      localizationsDelegates: [
        FlutterLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }

        for (Locale supportedLocale in supportedLocales) {
          if (locale != null) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.grey
      ),
      home: SplashScreen(),
    );
  }
}
