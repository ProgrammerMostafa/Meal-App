import 'package:flutter/material.dart';
import 'package:flutter_meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal _meal;

  const MealItem(
    this._meal, {
    Key? key,
  }) : super(key: key);

  String get complexityText {
    switch (_meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'unknown';
    }
  }

  String get affordabilityText {
    switch (_meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'unknown';
    }
  }

  void selectedMeal(BuildContext con) {
    Navigator.of(con).push(
      MaterialPageRoute(builder: (_) => MealDetailScreen(_meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 7.5, right: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () => selectedMeal(context),
        child: Card(
          color: Theme.of(context).canvasColor,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(0.0),
          elevation: 3,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Hero(
                      tag: _meal.id,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                        placeholder:
                            const AssetImage('assets/images/mealLoading.png'),
                        image: NetworkImage(_meal.imageUrl),
                      ),
                    ),
                  ),
                  ////////////////////
                  Positioned(
                    bottom: 15.0,
                    right: 10.0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 220.0,
                      color: Colors.black45,
                      child: Text(
                        _meal.title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
              /////////////////////////////////////////////
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /////////////////////////////////////////////////////////
                    rowIconText(
                      context,
                      Icons.schedule_rounded,
                      '${_meal.duration} min',
                    ),
                    /////////////////////////////////////////////////////////
                    rowIconText(
                      context,
                      Icons.work,
                      complexityText,
                    ),
                    /////////////////////////////////////////////////////////
                    rowIconText(
                      context,
                      Icons.attach_money_outlined,
                      affordabilityText,
                    ),
                    /////////////////////////////////////////////////////////
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row rowIconText(BuildContext ctx, IconData iconData, String textName) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Provider.of<ThemeProvider>(ctx).getColor,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          textName,
          style: Theme.of(ctx).textTheme.subtitle1,
        ),
      ],
    );
  }
}
