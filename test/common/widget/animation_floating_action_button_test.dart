import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/common/widget/animation_floating_action_button.dart';

void main() {
  group('AnimationFloatingActionButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: AnimationFloatingActionButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      // 기본 렌더링 확인
      expect(find.byType(AnimationFloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('button can be tapped', (WidgetTester tester) async {
      var buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: AnimationFloatingActionButton(
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      // 버튼 클릭
      await tester.tap(find.byType(AnimationFloatingActionButton));

      // 버튼 클릭 여부 확인
      expect(buttonPressed, isTrue);
    });

    testWidgets('animation runs correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: AnimationFloatingActionButton(
              onPressed: () {},
            ),
          ),
        ),
      );

      // 애니메이션 초기 상태 확인
      final initialSize = tester.getSize(find.byType(Container).first);
      expect(initialSize.width, equals(50.0));
      expect(initialSize.height, equals(50.0));

      // 애니메이션 진행
      await tester.pump(const Duration(milliseconds: 1000));

      // 애니메이션 중간 상태 확인
      final intermediateSize = tester.getSize(find.byType(Container).first);
      expect(intermediateSize.width, greaterThan(50.0));
      expect(intermediateSize.height, greaterThan(50.0));

      // 애니메이션 완료 상태 확인
      await tester.pump(const Duration(milliseconds: 1000));
      final finalSize = tester.getSize(find.byType(Container).first);
      expect(finalSize.width, equals(70.0));
      expect(finalSize.height, equals(70.0));
    });
  });
}
