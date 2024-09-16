import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task3/app/data/themeManager.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NOTE MANAGER",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeManager().getThemeMode(),    //theme manager object to manage which mode
    ),
  );
}
