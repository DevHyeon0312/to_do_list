import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/main_page.dart';
import 'package:to_do_list/app/feature/task/page/task_detail_page.dart';
import 'package:to_do_list/app/navigation/app_route.dart';
import 'package:to_do_list/common/util/platform_util.dart';
class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.main.name,
      page: () => const MainPage(),
      popGesture: AppRoute.main.canPop,
      transition: _getTransition(),
      transitionDuration: _getTransitionDuration(),
    ),
    GetPage(
      name: AppRoute.taskDetail.name,
      page: () => const TaskDetailPage(),
      popGesture: AppRoute.taskDetail.canPop,
      transition: _getTransition(),
      transitionDuration: _getTransitionDuration(),
    ),
  ];

  static Transition? _getTransition() {
    if (PlatformUtil.isAndroid()) {
      return Transition.rightToLeft;
    } else {
      return null;
    }
  }

  static Duration? _getTransitionDuration() {
    if (PlatformUtil.isAndroid()) {
      return const Duration(milliseconds: 200);
    } else {
      return null;
    }
  }
}