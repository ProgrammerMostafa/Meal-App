import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final bool _fromOnBoardingScreen;
  const FiltersScreen([
    this._fromOnBoardingScreen = false,
    Key? key,
  ]) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, bool> filters =
        Provider.of<MealProvider>(context).saved_filters;
    ////////////////
    return Scaffold(
      //////////////////////
      body: CustomScrollView(
        slivers: [
          if (widget._fromOnBoardingScreen == false)
            const SliverAppBar(
              pinned: true,
              title: Text('Your Filters'),
            ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //////////////////////////////////////////
                Container(
                  padding: EdgeInsets.only(
                    top: widget._fromOnBoardingScreen ? 65 : 15,
                    bottom: 15.0,
                  ),
                  child: Center(
                    child: Text(
                      'Adjust your meal selection.',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                ///////////////////////////////////////
                switchListTile(
                  context,
                  'Gluten-Free',
                  'Only include gluten-free meals',
                  'gluten',
                  filters,
                ),
                ///////////////////////////////////////
                switchListTile(
                  context,
                  'Lactose-Free',
                  'Only include lactose-free meals',
                  'lactose',
                  filters,
                ),
                ///////////////////////////////////////
                switchListTile(
                  context,
                  'Vegetarian',
                  'Only include vegetarian meals',
                  'vegetarian',
                  filters,
                ),
                ///////////////////////////////////////
                switchListTile(
                  context,
                  'Vegan',
                  'Only include vegan meals',
                  'vegan',
                  filters,
                ),
                ///////////////////////////////////////
                if (widget._fromOnBoardingScreen) const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
      ////////////////////
      drawer: widget._fromOnBoardingScreen ? null : const MainDrawer(),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////
  SwitchListTile switchListTile(
    BuildContext ctx,
    String title,
    String subTitle,
    String filterValue,
    Map<String, bool> filter,
  ) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(ctx).textTheme.headline4),
      subtitle: Text(subTitle, style: Theme.of(ctx).textTheme.subtitle1),
      value: filter[filterValue]!,
      onChanged: (_newVal) {
        setState(() {
          filter[filterValue] = _newVal;
        });
        Provider.of<MealProvider>(ctx, listen: false).updateFilters();
      },
      activeColor: Provider.of<ThemeProvider>(context).accentColor,
      activeTrackColor:
          Provider.of<ThemeProvider>(context).accentColor.withOpacity(0.4),
      inactiveThumbColor: Colors.white.withOpacity(0.6),
      inactiveTrackColor: Colors.grey.withOpacity(0.4),
    );
  }
}
