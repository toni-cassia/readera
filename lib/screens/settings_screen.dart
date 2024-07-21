import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/book_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Consumer2<ThemeProvider, BookProvider>(
        builder: (context, themeProvider, bookProvider, child) {
          return ListView(
            children: [
              SwitchListTile(
                title: Text('Dark Mode'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
              ListTile(
                title: Text('Sort Books'),
                trailing: DropdownButton<String>(
                  value: bookProvider.sortOrder,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      bookProvider.setSortOrder(newValue);
                    }
                  },
                  items: <String>['title', 'author', 'rating']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.capitalize()),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}