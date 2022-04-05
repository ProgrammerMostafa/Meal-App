import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../screens/category_meals_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> selectedFilters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List _availableMeals = DUMMY_MEALS;
  final List _favoriteMeals = [];

  void toggleFavorite(String _mealID) {
    final resultIndex = _favoriteMeals.indexWhere((meal) => meal.id == _mealID);
    setState(() {
      if (resultIndex >= 0) {
        _favoriteMeals.removeAt(resultIndex);
      } else {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == _mealID));
      }
    });
  }

  bool isFavorite(String _mealID) {
    return _favoriteMeals.any((meal) => meal.id == _mealID);
  }

  void saveData(Map<String, bool> _filters) {
    setState(() {
      selectedFilters = _filters;
    });
    _availableMeals = DUMMY_MEALS.where((meal) {
      if (selectedFilters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (selectedFilters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (c) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(listMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              onChangedFavorite: toggleFavorite,
              isFavorite: isFavorite,
              favoriteMeals: _favoriteMeals,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
            savedFilters: selectedFilters, saveFiltersData: saveData),
      },
    );
  }
}
