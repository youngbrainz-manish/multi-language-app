import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_language_app/core/app_colors.dart';
import 'package:multi_language_app/core/app_constants.dart';
import 'package:multi_language_app/localization/delegation.dart';
import 'package:multi_language_app/provider/theme_provider.dart';
import 'package:multi_language_app/screen/home_screen.dart';
import 'package:multi_language_app/screen/pageview/page_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/language_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences? prefs;
  const MyApp({super.key, required this.prefs});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors().primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: AppColors().primaryColor,
      titleTextStyle: const TextStyle(color: Colors.white),
      iconTheme: const IconThemeData().copyWith(color: Colors.white),
    ),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors().primaryDarkColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: AppColors().primaryDarkColor,
      titleTextStyle: const TextStyle(color: Colors.white),
      iconTheme: const IconThemeData().copyWith(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return materialApp(provider: provider, prefs: widget.prefs);
        },
      ),
    );
  }

  MaterialApp materialApp({required ThemeProvider provider, SharedPreferences? prefs}) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      title: 'Multi Language',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: 1 == 2 ? const OnBoardingPage() : const Home(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: prefs?.getString(AppConstants().stringTheme) == 'light' ? ThemeMode.light : ThemeMode.dark,
      supportedLocales: const [Locale('en', ''), Locale('hi', '')],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
