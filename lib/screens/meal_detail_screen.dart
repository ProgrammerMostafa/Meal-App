import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../screens/tabs_screen.dart';

class MealDetailScreen extends StatefulWidget {
  final Function onChangedFavorite;
  final Function isFavorite;
  final List favoriteMeals;

  const MealDetailScreen({
    Key? key,
    required this.onChangedFavorite,
    required this.isFavorite,
    required this.favoriteMeals,
  }) : super(key: key);

  static const String routeName = '/meal_detail';

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final dataSent = ModalRoute.of(context)?.settings.arguments as Map;
    final mealID = dataSent['id'];
    final screenType = dataSent['screenType'];
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        leading: screenType
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (c) => TabsScreen(
                            favoriteMeals: widget.favoriteMeals,
                            currentIndex: 1)),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.cover),
            ),
            //////////////////////////////////////
            buildContainer(context, 'Ingredients'),
            //////////////////////////////////////
            buildContainer2(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (con, index) {
                  return Card(
                    color: Colors.tealAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            //////////////////////////////////////
            buildContainer(context, 'Steps'),
            //////////////////////////////////////
            buildContainer2(
              ListView.separated(
                itemCount: meal.steps.length,
                itemBuilder: (con, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('#${index + 1}'),
                    ),
                    title: Text(
                      meal.steps[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
                separatorBuilder: (con, index) {
                  return const Divider(
                    color: Colors.black,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.onChangedFavorite(mealID);
          });
        },
        child: Icon(widget.isFavorite(mealID) ? Icons.star : Icons.star_border),
      ),
    );
  }
}

///////////////////////// Functions ///////////////////////////////////
///////////////////////////////////////////////////////////////////
Widget buildContainer(BuildContext con, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      text,
      style: Theme.of(con).textTheme.titleMedium,
    ),
  );
}

///////////////////////////////////////////////////////////////////
Widget buildContainer2(child) {
  return Container(
    height: 150,
    width: 280,
    padding: const EdgeInsets.all(6),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: child,
  );
}
