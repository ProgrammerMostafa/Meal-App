import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../screens/category_meals_screen.dart';

class CategoriesItem extends StatelessWidget {
  final String _id;
  final String _title;
  final Color _color;

  const CategoriesItem(
    this._id,
    this._title,
    this._color, {
    Key? key,
  }) : super(key: key);

  void selectedCategory(BuildContext con) {
    Provider.of<MealProvider>(con, listen: false).filteringSpecificMeals(_id);
    /////////////////////
    Navigator.of(con).push(
      MaterialPageRoute(
        builder: (_) => CategoryMealsScreen(_title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedCategory(context),
      splashColor: _color,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          _title,
          style: Theme.of(context).textTheme.headline3,
        ),
        decoration: BoxDecoration(
          color: _color,
          gradient: LinearGradient(
            colors: [
              _color.withOpacity(0.5),
              _color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: _color, width: 1.0),
        ),
      ),
    );
  }
}
