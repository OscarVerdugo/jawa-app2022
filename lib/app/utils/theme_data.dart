import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class CustomThemeData {
  late BuildContext context;
  CustomThemeData(BuildContext _context) {
    context = _context;
  }
  get theme {
    return Theme.of(context).copyWith(
        scaffoldBackgroundColor: UIColors.lightColor,
        appBarTheme: appBarTheme,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme));
  }

  get appBarTheme {
    return Theme.of(context).appBarTheme.copyWith(
        color: UIColors.lightColor,
        foregroundColor: UIColors.darkColor,
        elevation: 0);
  }
}
