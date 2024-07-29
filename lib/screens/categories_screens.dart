import 'package:flutter/material.dart';
import 'package:meals/components/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: dummyCategories.map((cat) {
        return CategoryItem(cat);
      }).toList(),
    );
  }
}
