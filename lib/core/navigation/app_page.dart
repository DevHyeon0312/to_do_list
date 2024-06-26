import 'package:get/get.dart';
import 'package:to_do_list/core/navigation/app_route.dart';
import 'package:to_do_list/feature/main/main_page.dart';
class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.main.name,
      page: () => const MainPage(),
      popGesture: AppRoute.main.canPop,
    ),
  ];
}