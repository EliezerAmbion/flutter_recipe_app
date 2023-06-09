import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_card.dart';

// this is the homepage
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: DUMMY_CATEGORIES
          .map(
            (catData) => CategoryCard(
              id: catData.id,
              title: catData.title,
              color: catData.color,
            ),
          )
          .toList(),
    );
  }
}
