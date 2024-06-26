import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/main_page.dart';
import 'package:to_do_list/app/navigation/app_route.dart';
class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.main.name,
      page: () => const MainPage(),
      popGesture: AppRoute.main.canPop,
    ),
  ];
}