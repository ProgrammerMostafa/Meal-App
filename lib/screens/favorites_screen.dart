import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

class Favorites extends StatelessWidget {
  final List favorites;
  const Favorites({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (con, index) {
          return MealItem(
            imageUrl: favorites[index].imageUrl,
            title: favorites[index].title,
            duration: favorites[index].duration,
            complexity: favorites[index].complexity,
            affordability: favorites[index].affordability,
            id: favorites[index].id,
            checkScreen: false,
          );
        },
        itemCount: favorites.length,
      );
    }
  }
}
