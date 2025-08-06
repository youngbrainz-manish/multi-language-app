import 'package:flutter/material.dart';

class AppColors {
  Color primaryColor = const Color(0xFF344BFD);
  Color primaryDarkColor = const Color(0xFF494949);
  Color buttonColor = const Color(0xFF344BFD);
  static Color bodyBgColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF272727) : const Color(0xFFAFFFAA);
  static Color fillColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF272727) : const Color(0xFF272727);
  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xFF494949) : const Color(0xFF344BFD);
}
