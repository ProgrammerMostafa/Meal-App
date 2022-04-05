import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routeName = '/categories_meals';

  final List listMeals;

  const CategoryMealsScreen({
    Key? key,
    required this.listMeals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = arg['id'].toString();
    final categoryTitle = arg['title'].toString();
    final meals = listMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (con, index) {
          return MealItem(
            imageUrl: meals[index].imageUrl,
            title: meals[index].title,
            duration: meals[index].duration,
            complexity: meals[index].complexity,
            affordability: meals[index].affordability,
            id: meals[index].id,
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
