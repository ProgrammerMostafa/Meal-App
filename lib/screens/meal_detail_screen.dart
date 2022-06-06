import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../models/tools/themes_data.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal _meal;

  const MealDetailScreen(this._meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
    ////////////////
    return Scaffold(
      //////////////////////////////////////////
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 30,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.black,
            //////////////////
            title: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              color: Colors.black38,
              child: Text(
                _meal.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            //////////////////
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: InteractiveViewer(
              maxScale: 5.0,
              child: Hero(
                tag: _meal.id,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder:
                      const AssetImage('assets/images/mealLoading.png'),
                  image: NetworkImage(_meal.imageUrl),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //////////////////////////////////////
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  direction:
                      ThemesData.orientation(context) == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                  children: [
                    ///////// first column //////////////////
                    Column(
                      children: [
                        ////////////////////////////////
                        buildContainer(context, 'Ingredients'),
                        ////////////////////////////////
                        buildContainer2(
                          context,
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _meal.ingredients.length,
                            itemBuilder: (con, index) {
                              return Card(
                                color: _themeProvider.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    _meal.ingredients[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'RobotoCondensed',
                                      fontWeight: FontWeight.w600,
                                      color: useWhiteForeground(
                                              _themeProvider.primaryColor)
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ///////////////////////////
                      ],
                    ),
                    ///////// second column //////////////////
                    Column(
                      children: [
                        ////////////////////////////////
                        buildContainer(context, 'Steps'),
                        ////////////////////////////////
                        buildContainer2(
                          context,
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: _meal.steps.length,
                            separatorBuilder: (_, index) =>
                                Divider(color: _themeProvider.getColor),
                            itemBuilder: (con, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: _themeProvider.primaryColor,
                                  foregroundColor: useWhiteForeground(
                                          _themeProvider.primaryColor)
                                      ? Colors.white.withOpacity(0.9)
                                      : Colors.black,
                                  child: Text('#${index + 1}'),
                                ),
                                title: Text(
                                  _meal.steps[index],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              );
                            },
                          ),
                        ),
                        ////////////////////////////////
                      ],
                    ),
                  ],
                ),
                /////////////////////
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _themeProvider.accentColor,
        foregroundColor: useWhiteForeground(_themeProvider.accentColor)
            ? Colors.white.withOpacity(0.9)
            : Colors.black,
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .changeFavoriteIcon(_meal.id),
        //////////////////////////////////////
        child: Provider.of<MealProvider>(context).isFavorite(_meal.id)
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),
    );
  }
}

/////////////////////////// Functions (Widget) //////////////////////////////
/////////////////////////////////////////////////////////////////////////////
Widget buildContainer(BuildContext con, String text) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    child: Text(
      text,
      style: Theme.of(con).textTheme.headline3,
    ),
  );
}

//////////////////////////////////////////////////////////////////////////////
Widget buildContainer2(
  BuildContext ctx,
  Widget child,
) {
  return Container(
    height: 160,
    width: ThemesData.orientation(ctx) == Orientation.portrait
        ? (ThemesData.screenWidth(ctx) / 1.3)
        : (ThemesData.screenWidth(ctx) / 2.3),
    padding: const EdgeInsets.all(6),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Theme.of(ctx).canvasColor,
      border: Border.all(color: Colors.blueGrey, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: child,
  );
}
