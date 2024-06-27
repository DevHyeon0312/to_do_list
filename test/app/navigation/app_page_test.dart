import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/main_page.dart';
import 'package:to_do_list/app/feature/task/page/task_detail_page.dart';
import 'package:to_do_list/app/navigation/app_page.dart';
import 'package:to_do_list/app/navigation/app_route.dart';

void main() {
  group('Android AppPage', () {
    setUp(() {
      AppPage.isAndroid = () => true;
    });

    test('pages are defined correctly', () {
      final pages = AppPage.pages;

      expect(pages.length, 2);

      final mainPage = pages.firstWhere((p) => p.name == AppRoute.main.name);
      final taskDetailPage = pages.firstWhere((p) => p.name == AppRoute.taskDetail.name);

      expect(mainPage.page(), isA<MainPage>());
      expect(mainPage.popGesture, AppRoute.main.canPop);
      expect(mainPage.transition, Transition.rightToLeft);
      expect(mainPage.transitionDuration, const Duration(milliseconds: 200));

      expect(taskDetailPage.page(), isA<TaskDetailPage>());
      expect(taskDetailPage.popGesture, AppRoute.taskDetail.canPop);
      expect(taskDetailPage.transition, Transition.rightToLeft);
      expect(taskDetailPage.transitionDuration, const Duration(milliseconds: 200));
    });
  });
}
