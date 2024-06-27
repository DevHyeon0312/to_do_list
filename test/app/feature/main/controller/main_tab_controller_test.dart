import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/controller/main_tab_controller.dart';

void main() {
  group('MainTabController', () {
    late MainTabController controller;

    setUp(() {
      controller = MainTabController();
      Get.put(controller);
    });

    tearDown(() {
      Get.delete<MainTabController>();
    });

    test('initial selectedIndex is 0', () {
      expect(controller.selectedIndex, 0);
    });

    test('onItemTapped updates selectedIndex', () {
      controller.onItemTapped(1);
      expect(controller.selectedIndex, 1);

      controller.onItemTapped(2);
      expect(controller.selectedIndex, 2);
    });
  });
}
