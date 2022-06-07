import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../tools/themes_data.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String _categoryTitle;

  const CategoryMealsScreen(
    this._categoryTitle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Meal> _listSpecificMeals =
        Provider.of<MealProvider>(context).specificMeals;
    ////////////////////////////
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: _listSpecificMeals.length,
        itemBuilder: (_, index) {
          return MealItem(_listSpecificMeals[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ThemesData.orientation(context) == Orientation.portrait
                  ? 1
                  : (ThemesData.screenWidth(context) / 2 < 280 ? 1 : 2),
          mainAxisExtent: 205, //height
        ),
      ),
    );
  }
}
