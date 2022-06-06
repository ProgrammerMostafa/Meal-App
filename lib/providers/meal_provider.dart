import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class MealProvider extends ChangeNotifier {
  /////////////////////////////////////////////////////////////////////////////////////
  ////////// Change index of bottom bar tab /////////////////////////////////////////
  int _currentIndex_tabScreen = 0;
  int get currentIndex_tabScreen => _currentIndex_tabScreen;
  void changeIndex(int _newIndex) {
    _currentIndex_tabScreen = _newIndex;
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////
  //// According to filtration update allAvailableMeals & allAvailableCategories//////
  final Map<String, bool> _map_filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  Map<String, bool> get saved_filters => _map_filters;

  ////////////////////////
  List<Meal> _allAvailableMeals = [];
  List<Category> _allAvailableCategories = [];
  List<Category> get allAvailableCategories => _allAvailableCategories;

  void updateFilters() async {
    ////////////////////////////////////////////////////////////
    //// Update availableMeals according to new selected filters
    _allAvailableMeals = DUMMY_MEALS.where((meal) {
      if ((_map_filters['gluten']! && !meal.isGlutenFree) ||
          (_map_filters['lactose']! && !meal.isLactoseFree) ||
          (_map_filters['vegetarian']! && !meal.isVegetarian) ||
          (_map_filters['vegan']! && !meal.isVegan)) {
        return false;
      } else {
        return true;
      }
    }).toList();

    /////////////////////////////////////////////////////////////////
    //// Update availableCategories according to new selected filters
    _allAvailableCategories = DUMMY_CATEGORIES.where((_category) {
      return _allAvailableMeals.any(
        (_meal) => _meal.categories.contains(_category.id),
      );
    }).toList();

    /////////////////////////////////////////////////////////////////
    //// Update favoriteMeals according to new selected filters
    _favoriteMeals.clear(); //clear all meals
    for (var _mealID in _allFavoriteMealsID) {
      // if index == -1 -> that meal not found in _allAvailableMeals
      int index = _allAvailableMeals.indexWhere((meal) => meal.id == _mealID);  
      if (index >= 0) {
        _favoriteMeals.add(_allAvailableMeals[index]);
      }
    }

    /////////////////
    notifyListeners();

    ////// Saving your filters in shared preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('gluten', _map_filters['gluten']!);
    _prefs.setBool('lactose', _map_filters['lactose']!);
    _prefs.setBool('vegetarian', _map_filters['vegetarian']!);
    _prefs.setBool('vegan', _map_filters['vegan']!);
  }

  /////////////////////////////////////////////////////////////////////////////////////
  ///////////// Filtering meals according to selected category ///////////////////////
  List<Meal> _specificMeals = [];
  List<Meal> get specificMeals => _specificMeals;
  //// filtering available meals according to selected category
  void filteringSpecificMeals(String _categoryID) {
    _specificMeals = _allAvailableMeals
        .where((meal) => meal.categories.contains(_categoryID))
        .toList();
    /////////////////
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////////
  //////// Change favorite icon & updating favorite meals /////////////////////////////
  final List<Meal> _favoriteMeals = [];
  List<Meal> get favoriteMeals => _favoriteMeals;

  List<String> _allFavoriteMealsID = [];

  void changeFavoriteIcon(String _mealID) async {
    //// Check if this meal added in favorite meals
    //// --> if resultIndex == -1 that's main not added in favorite meals
    final resultIndex = _favoriteMeals.indexWhere((meal) => meal.id == _mealID);

    if (resultIndex >= 0) {
      _favoriteMeals.removeAt(resultIndex);
      _allFavoriteMealsID.remove(_mealID);
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == _mealID));
      _allFavoriteMealsID.add(_mealID);
    }
    /////////////////
    notifyListeners();

    //// Saving your favorites in shared preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList('allFavoriteMealsID', _allFavoriteMealsID);
  }

  //////////////////////////////
  bool isFavorite(String _mealID) {
    return _favoriteMeals.any((meal) => meal.id == _mealID);
  }

  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////
  void getSavedDataFromSharedPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    /////////////////////////////////////////////////////////////////
    //////// Get your saved favorite meals from shared preferences
    _allFavoriteMealsID = _prefs.getStringList('allFavoriteMealsID') ?? [];

    /////////////////////////////////////////////////////////////////
    ////////// Get your saved filters from shared preferences
    _map_filters['gluten'] = _prefs.getBool('gluten') ?? false;
    _map_filters['lactose'] = _prefs.getBool('lactose') ?? false;
    _map_filters['vegetarian'] = _prefs.getBool('vegetarian') ?? false;
    _map_filters['vegan'] = _prefs.getBool('vegan') ?? false;

    ///////////////
    updateFilters(); // Call the function
  }
}
