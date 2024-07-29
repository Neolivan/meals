import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screens.dart';
import './screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData();
  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.pink,
            secondary: Colors.amber,
          ),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.pink,
            foregroundColor: const Color.fromARGB(255, 27, 7, 7),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                ),
              ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.amber,
          )),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreens(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(
              _availableMeals,
            ),
        AppRoutes.MEAL_DETAIL: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(_filterMeals, settings),
      },
    );
  }
}
