import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primaryColor = const Color(0xff035858);
  Color _accentColor = const Color(0xFFFFC107);
  ThemeMode _tm = ThemeMode.system;

  Color get primaryColor => _primaryColor;
  Color get accentColor => _accentColor;
  ThemeMode get themeMode => _tm;

  ////////////////////////////////////////////////////////////////
  Color get getColor {
    if (_tm == ThemeMode.dark) {
      return Colors.white.withOpacity(0.8);
    } else if (_tm == ThemeMode.light) {
      return Colors.black;
    } else {
      final Brightness brightN =
          SchedulerBinding.instance!.window.platformBrightness;
      return brightN == Brightness.dark
          ? Colors.white.withOpacity(0.8)
          : Colors.black;
    }
  }

  ////////////////////////////////////////////////////////////////
  void changeThemeMode(ThemeMode newTheme) async {
    _tm = newTheme;
    /////////////////
    notifyListeners();
    //////////////////
    //// Saving ThemeMode in shared preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String themeType =
        newTheme.toString().split('.')[1]; //-> system, light or dark
    _prefs.setString('themeType', themeType);
  }

  ////////////////////////////////////////////////////////////////
  void changeColor(String type, Color newColor) async {
    type == 'primary' ? _primaryColor = newColor : _accentColor = newColor;
    /////////////////
    notifyListeners();
    ///////////////////////
    ///// Saving a selected color in shared preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('primaryColor', _primaryColor.value);
    _prefs.setInt('accentColor', _accentColor.value);
  }

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  void getSavedDataFromSharedPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    /////////////////////////////////////////////////////////////////
    ////////// Get your saved theme from shared preferences
    String themeType =
        _prefs.getString('themeType') ?? 'system'; //-> system, light or dark
    _tm = themeType == 'system'
        ? ThemeMode.system
        : (themeType == 'dark' ? ThemeMode.dark : ThemeMode.light);

    /////////////////////////////////////////////////////////////////
    ////////// Get your saved colors from shared preferences
    _primaryColor = Color(_prefs.getInt('primaryColor') ?? 0xFF009688);
    _accentColor = Color(_prefs.getInt('accentColor') ?? 0xFFFFC107);

    /////////////////
    notifyListeners();
  }
}
