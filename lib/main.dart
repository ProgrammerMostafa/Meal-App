import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tools/themes_data.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/on_boarding_screen.dart';
import '../screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //////////////////////////////////////////
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  Widget _homeScreen = _prefs.getBool('watch_onBoarding_screen') == null
      ? const OnBoardingScreen()
      : const TabsScreen();
  //////////////////////////////////////////
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(_homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {

  final Widget _homeScreen;
  const MyApp(
    this._homeScreen, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /////////////////////////
    final Color primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    final Color accentColor = Provider.of<ThemeProvider>(context).accentColor;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: ThemeData(
        canvasColor: const Color(0xFFFFFFFF), //
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 249, 252, 235), // for any scaffold
        ///////////////////////////////////////////////
        appBarTheme: ThemesData.appBarTheme(primaryColor),
        ///////////////////////////////////////////////
        bottomNavigationBarTheme:
            ThemesData.bottomNavigationBarTheme(primaryColor, accentColor),
        ///////////////////////////////////////////////
        textTheme: TextTheme(
          ///////////////////
          headline1: ThemesData.createTextStyle(24, FontWeight.bold,
              color: accentColor),
          ///////////////////
          headline2: ThemesData.createTextStyle(21, FontWeight.w600,
              color: Colors.black),
          ///////////////////
          headline3: ThemesData.createTextStyle(18, FontWeight.w600,
              color: Colors.black),
          ///////////////////
          headline4: ThemesData.createTextStyle(16, FontWeight.w600,
              color: Colors.black),
          ///////////////////
          subtitle1: ThemesData.createTextStyle(15, FontWeight.w400,
              color: Colors.black),
          ///////////////////
        ),
        ///////////////////////////////////////////////
        radioTheme: ThemesData.radioThemeData(),
        ///////////////////////////////////////////////
        iconTheme: ThemesData.iconThemeData(primaryColor),
      ),
      ////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////
      darkTheme: ThemeData(
        primaryIconTheme: ThemesData.iconThemeData(primaryColor),
        canvasColor: const Color.fromARGB(255, 29, 29, 29), //
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 17, 17, 17), // for any scaffold
        ///////////////////////////////////////////////
        appBarTheme: ThemesData.appBarTheme(primaryColor),
        ///////////////////////////////////////////////
        bottomNavigationBarTheme:
            ThemesData.bottomNavigationBarTheme(primaryColor, accentColor),
        ///////////////////////////////////////////////
        textTheme: TextTheme(
          ///////////////////
          headline1: ThemesData.createTextStyle(24, FontWeight.bold,
              color: accentColor),
          ///////////////////
          headline2: ThemesData.createTextStyle(22, FontWeight.w500),
          ///////////////////
          headline3: ThemesData.createTextStyle(18, FontWeight.w600),
          ///////////////////
          headline4: ThemesData.createTextStyle(16, FontWeight.w600),
          ///////////////////
          subtitle1: ThemesData.createTextStyle(15, FontWeight.w400),
          ///////////////////
        ),
        ///////////////////////////////////////////////
        radioTheme: ThemesData.radioThemeData(),
        ///////////////////////////////////////////////
        iconTheme: ThemesData.iconThemeData(primaryColor),
      ),
      home: _homeScreen, //-> OnBoardingScreen() or TabsScreen()
    );
  }
}
