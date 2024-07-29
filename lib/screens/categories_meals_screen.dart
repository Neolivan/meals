import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';
import '../models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;
  CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: ListView.builder(
            itemCount: categoryMeals.length,
            itemBuilder: (ctx, index) {
              return MealItem(categoryMeals[index]);
            }),
      ),
    );
  }
}
