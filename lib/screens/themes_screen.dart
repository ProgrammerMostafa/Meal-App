import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../screens/tabs_screen.dart';
import '../widgets/main_drawer.dart';

class ThemesScreen extends StatelessWidget {
  final bool _fromOnBoardingScreen;
  const ThemesScreen([
    this._fromOnBoardingScreen = false,
    Key? key,
  ]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TabsScreen(),
          ),
        );
        return true;
      },
      child: Scaffold(
        //////////////////////
        body: CustomScrollView(
          slivers: [
            if (_fromOnBoardingScreen == false)
              const SliverAppBar(
                pinned: true,
                title: Text('Your Themes'),
              ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //////////////////////////////////////////
                  Container(
                    alignment: Alignment.center,
                    padding: _fromOnBoardingScreen
                        ? const EdgeInsets.only(top: 50)
                        : null,
                    child:
                        buildContainer(context, 'Adjust your theme selection.'),
                  ),
                  ///////////////////////////////////////
                  buildContainer(context, 'Choose your Theme mode'),
                  ///////////////////////////////////////
                  buildRadioListTile(
                    context,
                    'System Defult Theme',
                    null,
                    ThemeMode.system,
                  ),
                  ///////////////////////////////////////
                  buildRadioListTile(
                    context,
                    'Light Theme',
                    Icons.wb_sunny,
                    ThemeMode.light,
                  ),
                  ///////////////////////////////////////
                  buildRadioListTile(
                    context,
                    'Dark Theme',
                    Icons.nights_stay_outlined,
                    ThemeMode.dark,
                  ),
                  ///////////////////////////////////////
                  buildListTile(context, 'primary'),
                  buildListTile(context, 'accent'),
    
                  ///////////////////////////////////////
                  if (_fromOnBoardingScreen) const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
        ////////////////////
        drawer: _fromOnBoardingScreen ? null : const MainDrawer(),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////
  Container buildContainer(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  RadioListTile buildRadioListTile(
    BuildContext ctx,
    String titleText,
    IconData? iconData,
    ThemeMode themeValue,
  ) {
    final ThemeProvider _themeProvider = Provider.of<ThemeProvider>(ctx);
    return RadioListTile(
      value: themeValue,
      groupValue: _themeProvider.themeMode,
      onChanged: (newThemeVal) {
        Provider.of<ThemeProvider>(ctx, listen: false)
            .changeThemeMode(newThemeVal!);
      },
      activeColor: Provider.of<ThemeProvider>(ctx).accentColor,
      title: Text(titleText, style: Theme.of(ctx).textTheme.headline4),
      secondary: iconData == null
          ? null
          : Icon(iconData, color: _themeProvider.getColor),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  ListTile buildListTile(
    BuildContext ctx,
    String titleText,
  ) {
    final ThemeProvider _themeProvider = Provider.of<ThemeProvider>(ctx);

    return ListTile(
      title: Text(
        'Choose your $titleText color',
        style: Theme.of(ctx).textTheme.headline3,
      ),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: CircleAvatar(
          backgroundColor: titleText == 'primary'
              ? _themeProvider.primaryColor
              : _themeProvider.accentColor,
        ),
        onTap: () async {
          await showDialog(
            context: ctx,
            builder: (_) => AlertDialog(
              scrollable: true,
              elevation: 4.0,
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: ColorPicker(
                pickerColor: titleText == 'primary'
                    ? _themeProvider.primaryColor
                    : _themeProvider.accentColor,
                onColorChanged: (newColor) {
                  Provider.of<ThemeProvider>(ctx, listen: false)
                      .changeColor(titleText, newColor);
                },
                labelTypes: const [],
                displayThumbColor: true,
                enableAlpha: false,
                pickerAreaHeightPercent: 0.6,
                portraitOnly: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
