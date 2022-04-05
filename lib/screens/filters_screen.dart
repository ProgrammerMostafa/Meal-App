import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFiltersData;
  final Map<String, bool> savedFilters;

  const FiltersScreen({
    Key? key,
    required this.saveFiltersData,
    required this.savedFilters,
  }) : super(key: key);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _glutenFree = widget.savedFilters['gluten'] as bool;
      _lactoseFree = widget.savedFilters['lactose'] as bool;
      _vegan = widget.savedFilters['vegan'] as bool;
      _vegetarian = widget.savedFilters['vegetarian'] as bool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Map<String, bool> _selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFiltersData(_selectedFilters);
              });
            },
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ///////////////////////////////////////
                buildSwitch(
                  'Gluten-Free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  },
                ),
                ///////////////////////////////////////
                buildSwitch(
                  'Lactose-Free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  },
                ),
                ///////////////////////////////////////
                buildSwitch(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (val) {
                    setState(() {
                      _vegetarian = val;
                    });
                  },
                ),
                ///////////////////////////////////////
                buildSwitch(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                  (val) {
                    setState(() {
                      _vegan = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }

  ///////////////////////////////////////////////////////////////////
  SwitchListTile buildSwitch(
    String _title,
    String _description,
    bool _currentVal,
    Function(bool val)? _onChanged,
  ) {
    return SwitchListTile(
      value: _currentVal,
      onChanged: _onChanged,
      title: Text(_title),
      subtitle: Text(_description),
    );
  }
}
