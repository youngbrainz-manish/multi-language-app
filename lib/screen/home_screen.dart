import 'package:flutter/material.dart';
import 'package:multi_language_app/core/app_colors.dart';
import 'package:multi_language_app/language/languages.dart';
import 'package:multi_language_app/localization/language_constant.dart';
import 'package:multi_language_app/model/language_model.dart';
import 'package:multi_language_app/provider/theme_provider.dart';
import 'package:multi_language_app/screen/new_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Languages.of(context)!.appName,
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ThemeProvider themeNotifier = Provider.of<ThemeProvider>(context, listen: false);
              if (themeNotifier.themeMode == ThemeMode.light) {
                themeNotifier.setTheme(ThemeMode.dark);
              } else {
                themeNotifier.setTheme(ThemeMode.light);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.forward),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80),
                Text(
                  Languages.of(context)!.welcomeText,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Text(
                  Languages.of(context)!.appDescription,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                _createLanguageDropDown()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor(context), width: 2), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<LanguageModel>(
        underline: const SizedBox(),
        iconSize: 30,
        hint: Text(Languages.of(context)!.selectLanguage),
        onChanged: (LanguageModel? language) {
          changeLanguage(context, language!.languageCode);
        },
        items: LanguageModel.languageList()
            .map<DropdownMenuItem<LanguageModel>>(
              (e) => DropdownMenuItem<LanguageModel>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Text(
                      e.country,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(width: 10),
                    Text(e.languageName)
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
