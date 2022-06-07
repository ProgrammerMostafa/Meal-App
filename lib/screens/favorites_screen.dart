import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../tools/themes_data.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Meal> favorites = Provider.of<MealProvider>(context).favoriteMeals;
    ////////////////////////
    if (favorites.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet - start adding some!',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: favorites.length,
        itemBuilder: (con, index) {
          return MealItem(favorites[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ThemesData.orientation(context) == Orientation.portrait
                  ? 1
                  : (ThemesData.screenWidth(context) / 2 < 280 ? 1 : 2),
          mainAxisExtent: 205, //height
        ),
      );
    }
  }
}
