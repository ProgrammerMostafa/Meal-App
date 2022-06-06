import 'package:flutter/material.dart';
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
    return Scaffold(
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
    );
  }
}
