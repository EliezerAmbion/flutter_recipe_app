import 'package:flutter/material.dart';

import '../views/filters_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(BuildContext context, String title, IconData icon,
      VoidCallback? tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline4,
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Recipe App',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(context, 'Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(context, 'Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersView.routeName);
          }),
        ],
      ),
    );
  }
}
