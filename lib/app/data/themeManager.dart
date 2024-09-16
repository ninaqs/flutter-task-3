import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//a theme manager to help managing the current theme with home controller
class ThemeManager {
  final lightTheme = ThemeMode.light;
  final darkTheme = ThemeMode.dark;
  var isDark = false.obs;

  final themeBox = GetStorage();

  void saveThemeData(bool isDarkMode) {
    //saving current mode locally
    themeBox.write('isDark', isDarkMode);
  }

  bool isSavedDarkMode() {
    return themeBox.read('isDark') ??
        false; //getting mode and returning light mode if not initialized
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode()
        ? ThemeMode.dark
        : ThemeMode.light; //getting theme value
  }

  void changeTheme() {
    //changing theme using Get and updating value in local memoty
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
