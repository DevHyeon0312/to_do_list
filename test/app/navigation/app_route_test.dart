import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/app/navigation/app_route.dart';

void main() {
  group('AppRoute', () {
    test('main route is defined correctly', () {
      expect(AppRoute.main.name, '/');
      expect(AppRoute.main.canPop, false);
    });

    test('taskDetail route is defined correctly', () {
      expect(AppRoute.taskDetail.name, '/task_detail');
      expect(AppRoute.taskDetail.canPop, true);
    });

    test('all routes are defined correctly', () {
      const routes = AppRoute.values;
      expect(routes.length, 2);
      expect(routes.contains(AppRoute.main), isTrue);
      expect(routes.contains(AppRoute.taskDetail), isTrue);
    });
  });
}
