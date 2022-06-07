import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    super.initState();
    //// Get Saved data from SharedPreferences for (MealProvider)
    Provider.of<MealProvider>(context, listen: false)
        .getSavedDataFromSharedPreferences();

    //// Get Saved data from SharedPreferences for (ThemeProvider)
    Provider.of<ThemeProvider>(context, listen: false)
        .getSavedDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex =
        Provider.of<MealProvider>(context).currentIndex_tabScreen;
    /////////////////////
    return WillPopScope(
      onWillPop: _onWillPopFun,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentIndex == 0 ? 'Categories' : 'Your Favorites'),
        ),
        //////////////////////////////////////////////////////////////////////////
        body: _currentIndex == 0
            ? const CategoriesScreen()
            : const FavoriteScreen(),
        //////////////////////////////////////////////////////////////////////////
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: 'Your Favorites',
            ),
          ],
          onTap: (_selectedIndex) =>
              Provider.of<MealProvider>(context, listen: false)
                  .changeIndex(_selectedIndex),
        ),
        //////////////////////////////////////////////////////////////////////////
        drawer: const MainDrawer(),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  Future<bool> _onWillPopFun() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an Application'),
        actions: <Widget>[
          Row(
            children: [
              Expanded(child: _elevatedButton(isYesBtn: false)),
              /////////////////////////////
              const SizedBox(width: 15),
              /////////////////////////////
              Expanded(child: _elevatedButton(isYesBtn: true)),
            ],
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
    );
  }

  ElevatedButton _elevatedButton({required bool isYesBtn}) {
    Color _primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    Color _color = Theme.of(context).canvasColor;
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(isYesBtn),
      child: Text(isYesBtn ? 'Yes' : 'No'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isYesBtn ? _primaryColor : _color,
        ),
        foregroundColor: MaterialStateProperty.all(
          useWhiteForeground(isYesBtn ? _primaryColor : _color)
              ? Colors.white.withOpacity(0.9)
              : Colors.black,
        ),
        elevation: MaterialStateProperty.all(1.0)
      ),
    );
  }
}
