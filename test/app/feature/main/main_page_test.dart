import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:to_do_list/app/feature/main/controller/main_tab_controller.dart';
import 'package:to_do_list/app/feature/main/main_page.dart';
import 'package:to_do_list/app/feature/task/page/task_pending_list_page.dart';
import 'package:to_do_list/app/feature/task/page/task_ongoing_list_page.dart';
import 'package:to_do_list/app/feature/task/page/task_complete_list_page.dart';
import 'package:to_do_list/app/navigation/app_binding.dart';

void main() {
  group('MainPage', () {
    setUp(() {
      Get.put(MainTabController());
    });

    tearDown(() {
      Get.delete<MainTabController>();
    });

    testWidgets('pending page', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MainPage(),
          initialBinding: AppBinding(),
        ),
      );

      await tester.tap(find.byIcon(Icons.task_outlined));
      expect(find.byType(TaskPendingPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.timer));
      expect(find.byType(TaskOngoingListPage), findsNothing);

      await tester.tap(find.byIcon(Icons.task_alt_outlined));
      expect(find.byType(TaskCompleteListPage), findsNothing);
    });

    testWidgets('ongoing pagee', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MainPage(),
          initialBinding: AppBinding(),
        ),
      );

      await tester.tap(find.byIcon(Icons.timer));
      expect(find.byType(TaskOngoingListPage), findsNothing);
    });

    testWidgets('complete page', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MainPage(),
          initialBinding: AppBinding(),
        ),
      );

      await tester.tap(find.byIcon(Icons.task_alt_outlined));
      expect(find.byType(TaskCompleteListPage), findsNothing);
    });
  });
}
