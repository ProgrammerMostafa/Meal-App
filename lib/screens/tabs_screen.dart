import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List favoriteMeals;
  final int currentIndex;

  const TabsScreen({
    Key? key,
    required this.favoriteMeals,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _currentIndex = 0;

  List<Map<String, Object>> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': Favorites(favorites: widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_currentIndex]['title'].toString(),
        ),
      ),
      //////////////////////////////////////////////////////////////////////////
      body: _pages[_currentIndex]['page'] as Widget,
      //////////////////////////////////////////////////////////////////////////
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_outlined),
            label: _pages[0]['title'].toString(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_border_outlined),
            label: _pages[1]['title'].toString(),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
      ),
      //////////////////////////////////////////////////////////////////////////
      drawer: const MainDrawer(),
    );
  }
}
