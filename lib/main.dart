import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/navigation/app_page.dart';
import 'package:to_do_list/core/navigation/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoute.main.name,
      getPages: AppPage.pages,
    );
  }
}