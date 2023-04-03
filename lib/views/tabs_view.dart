import 'package:flutter/material.dart';

import '/models/meal.dart';

import '/widgets/bottom_nav_bar.dart';
import '/widgets/main_drawer.dart';

import 'categories_view.dart';
import 'favorites_view.dart';

class TabsView extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsView({
    super.key,
    required this.favoriteMeals,
  });

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesView(),
        'title': 'Categories',
      },
      {
        'page': FavoritesView(favoriteMeals: widget.favoriteMeals),
        'title': 'Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: const MainDrawer(), // Drawer
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavBar(
        selectPage: _selectPage,
        selectedPageIndex: _selectedPageIndex,
      ),
    );
  }
}
