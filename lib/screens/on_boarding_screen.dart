import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tools/themes_data.dart';
import '../providers/theme_provider.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/themes_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor =
        Provider.of<ThemeProvider>(context).primaryColor;
    final Color _accentColor = Provider.of<ThemeProvider>(context).accentColor;
    ////////////////
    return Scaffold(
      body: Stack(
        children: [
          //////////////////////////////////////////////////////////////
          PageView(
            children: [
              //////////////////////////////
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage('assets/images/image.jpg'),
                  ),
                ),
              ),
              //////////////////////////////
              const ThemesScreen(true),
              //////////////////////////////
              const FiltersScreen(true),
              //////////////////////////////
            ],
            onPageChanged: (_newIndex) {
              setState(() {
                _currentPageIndex = _newIndex;
              });
            },
          ),
          //////////////////////////////////////////////////////////////
          Builder(
            builder: (ctx) => Align(
              alignment: const Alignment(0, 0.82),
              child: ElevatedButton(
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: useWhiteForeground(_primaryColor)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                onPressed: () async {
                  Navigator.pushReplacement(
                    ctx,
                    MaterialPageRoute(builder: (_) => const TabsScreen()),
                  );
                  //////////////////////////
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  _prefs.setBool('watch_onBoarding_screen', true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_primaryColor),
                  fixedSize: MaterialStateProperty.all(
                    Size(ThemesData.screenWidth(ctx) - 10, 30),
                  ),
                ),
              ),
            ),
          ),
          //////////////////////////////////////////////////////////////
          Align(
            alignment: const Alignment(0, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ////////////////////
                buildIndicator(
                  _primaryColor,
                  _accentColor,
                  0,
                  _currentPageIndex,
                ),
                ////////////////////
                buildIndicator(
                  _primaryColor,
                  _accentColor,
                  1,
                  _currentPageIndex,
                ),
                ////////////////////
                buildIndicator(
                  _primaryColor,
                  _accentColor,
                  2,
                  _currentPageIndex,
                ),
                ////////////////////
              ],
            ),
          ),
          //////////////////////////////////////////////////////////////
        ],
      ),
    );
  }
}
  Widget buildIndicator(
    Color primaryColor,
    Color accentColor,
    int index,
    int currentIndex,
  ) {
    return currentIndex == index
        ? Icon(
            Icons.star,
            color: primaryColor,
          )
        : Container(
            margin: const EdgeInsets.all(5),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: accentColor,
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
          );
  }

