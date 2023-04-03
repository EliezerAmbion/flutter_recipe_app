import 'package:flutter/material.dart';

import '/widgets/main_drawer.dart';

class FiltersView extends StatefulWidget {
  static const routeName = '/filters';

  // saveFilters and currentFilters are coming from the route that is passed to FiltersView i.e. FiltersView(_setFilters),
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersView({
    super.key,
    required this.saveFilters,
    required this.currentFilters,
  });

  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['isGlutenFree']!;
    _isLactoseFree = widget.currentFilters['isLactoseFree']!;
    _isVegan = widget.currentFilters['isVegan']!;
    _isVegetarian = widget.currentFilters['isVegetarian']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'isGlutenFree': _isGlutenFree,
                'isLactoseFree': _isLactoseFree,
                'isVegan': _isVegan,
                'isVegetarian': _isVegetarian,
              };

              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(), // Drawer
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only include gluten-free meals',
                  _isGlutenFree,
                  (newvalue) {
                    setState(
                      () {
                        _isGlutenFree = newvalue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only include lactose-free meals',
                  _isLactoseFree,
                  (newvalue) {
                    setState(
                      () {
                        _isLactoseFree = newvalue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _isVegetarian,
                  (newvalue) {
                    setState(
                      () {
                        _isVegetarian = newvalue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals',
                  _isVegan,
                  (newvalue) {
                    setState(
                      () {
                        _isVegan = newvalue;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
