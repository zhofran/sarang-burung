// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:report_sarang/env/class/app_env.dart';
import 'package:report_sarang/env/variable/app_language.dart';

Future<void> main() async {
  initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Paint.enableDithering = true;
  
  runApp(
    EasyLocalization(
      supportedLocales: AppLanguage.values.map((e) => e.locale).toList(),
      path: 'assets/languages',
      fallbackLocale: const Locale('id'),
      useFallbackTranslations: true,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'report_sarang',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              if (supportedLocales.contains(Locale(locale!.languageCode))) {
                return locale;
              } else {
                return const Locale('id');
              }
            },
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme.light(
                background: Color(0xFFF7F8FA),
                onBackground: Color(0xff747474),
                surface: Color(0xffF5F5F5),
                shadow: Color(0xff000000),
                outline: Color(0xffF0F0F0),
                error: Color(0xFFF44336),
                primary: Color(0xFF1A3A6D),
                secondary: Color(0xFFFBB500),
              ),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              disabledColor: const Color(0xff696969),
              fontFamily: 'Poppins',
              textTheme: const TextTheme(
                labelMedium: TextStyle(
                    fontSize: 14,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold),
                labelSmall: TextStyle(
                    fontSize: 10, color: Color(0xff696969), letterSpacing: 0),
                bodySmall: TextStyle(fontSize: 12, color: Color(0xffffffff)),
                bodyMedium: TextStyle(fontSize: 14, color: Color(0xff696969)),
                bodyLarge: TextStyle(fontSize: 24),
              ),
              appBarTheme: const AppBarTheme(
                color: Color(0xFF1A7F09),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            routes: Env.routes,
            initialRoute: Env.initialRoute,
          );
        },
      ),
    ),
  );
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://86788b6ec1884780a97fd76bbadd7494@o4504400277078017.ingest.us.sentry.io/4506857261694976';
  //   },
  //   // Init your App.
  //   appRunner: () => 
  // );
}
