import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChange;
  final Settings settings;

  SettingsScreen(this.onSettingsChange, this.settings);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChange,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (val) {
        onChange(val);
        widget.onSettingsChange(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Configurações',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitch(
                  'Sem Gluten',
                  'Só exibe refeições sem glutén',
                  settings.isGlutenFree,
                  (value) => setState(() {
                        settings.isGlutenFree = value;
                      })),
              _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem Lactose',
                  settings.isLactoseFree,
                  (value) => setState(() {
                        settings.isLactoseFree = value;
                      })),
              _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganasn',
                  settings.isVegan,
                  (value) => setState(() {
                        settings.isVegan = value;
                      })),
              _createSwitch(
                  'Vegetariano',
                  'Só exibe refeições Vegetarianas',
                  settings.isVegetarian,
                  (value) => setState(() {
                        settings.isVegetarian = value;
                      })),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
