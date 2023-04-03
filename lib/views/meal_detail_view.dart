import 'package:flutter/material.dart';

import '/dummy_data.dart';

class MealDetailView extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailView({
    super.key,
    required this.toggleFavorite,
    required this.isMealFavorite,
  });

  buildSectionTitle(BuildContext context, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 35, bottom: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere(
      (meal) => meal.id == mealId,
    );

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Column(
                children: [
                  // Ingredients
                  buildSectionTitle(context, 'Ingredients'),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      elevation: 3,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text(
                            selectedMeal.ingredients[index],
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                    ),
                    itemCount: selectedMeal.ingredients.length,
                  ),

                  // Steps
                  buildSectionTitle(context, 'Steps'),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '${(index + 1)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                          ),
                          title: Text(
                            selectedMeal.steps[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Divider(color: Theme.of(context).colorScheme.primary),
                      ],
                    ),
                    itemCount: selectedMeal.steps.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
