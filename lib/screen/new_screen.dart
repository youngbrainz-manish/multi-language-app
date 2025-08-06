import 'package:flutter/material.dart';
import 'package:multi_language_app/core/app_colors.dart';
import 'package:multi_language_app/language/languages.dart';
import 'package:multi_language_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
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
        ],
      ),
      body: SafeArea(child: buildBody(context: context)),
    );
  }

  buildBody({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(100, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.bodyBgColor(context), borderRadius: BorderRadius.circular(10)),
              child: Text("Data $index"),
            );
          }),
        ),
      ),
    );
  }
}
