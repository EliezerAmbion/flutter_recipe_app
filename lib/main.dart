import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'dummy_data.dart';
import 'models/meal.dart';

import 'views/filters_view.dart';
import 'views/meal_detail_view.dart';
import 'views/category_meals_view.dart';
import 'views/tabs_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegan': false,
    'isVegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(final Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['isGlutenFree']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['isLactoseFree']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['isVegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['isVegetarian']! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: theme(),
      routes: {
        '/': (ctx) => TabsView(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsView.routeName: (ctx) => CategoryMealsView(
              availableMeals: _availableMeals,
            ),
        MealDetailView.routeName: (ctx) => MealDetailView(
              toggleFavorite: _toggleFavorite,
              isMealFavorite: _isMealFavorite,
            ),
        FiltersView.routeName: (ctx) => FiltersView(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
    );
  }
}
