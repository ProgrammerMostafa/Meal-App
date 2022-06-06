import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/themes_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(   //-> This widget used to set direction for any widget inside child 
      textDirection: TextDirection.ltr,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20.0),
              color: Provider.of<ThemeProvider>(context).primaryColor,
              child: Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ////////////////////////////////////////////
            const SizedBox(height: 20.0),
            ////////////////////////////////////////////
            buildListTile(
              context,
              'Meal',
              Icons.restaurant,
              () {
                Provider.of<MealProvider>(context, listen: false).changeIndex(0);
                //////////////////////////
                return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const TabsScreen()),
                );
              },
            ),
            ////////////////////////////////////////////
            buildListTile(
              context,
              'Filters',
              Icons.settings,
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const FiltersScreen()),
              ),
            ),
            ////////////////////////////////////////////
            buildListTile(
              context,
              'Themes',
              Icons.brightness_4,
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ThemesScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////// Fuctions ///////////////////////////////////
  ListTile buildListTile(
      BuildContext ctx, String title, IconData icon, Function()? _onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: Provider.of<ThemeProvider>(ctx).getColor,
      ),
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.headline2,
      ),
      onTap: _onTap,
    );
  }
}
