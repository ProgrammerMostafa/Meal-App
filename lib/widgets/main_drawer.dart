import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20.0),
            color: Colors.amber,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900),
            ),
          ),
          ////////////////////////////////////////////
          const SizedBox(
            height: 20.0,
          ),
          ////////////////////////////////////////////
          buildListTile('Meal', Icons.restaurant,
              () => Navigator.of(context).pushReplacementNamed('/')),
          ////////////////////////////////////////////
          buildListTile('Filters', Icons.settings,
              () => Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName)),
        ],
      ),
    );
  }

  ////////////////////////////// Fuctions ///////////////////////////////////
  ListTile buildListTile(String title, IconData icon, Function()? _onTap) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: _onTap,
    );
  }
}
