import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/common/widget/single_text_field.dart';

void main() {
  group('SingleTextField', () {
    testWidgets('renders correctly with given parameters', (WidgetTester tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      const hintText = 'Enter text';
      const backgroundColor = Colors.grey;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      // 위젯이 올바르게 렌더링 되는지 확인
      expect(find.byType(SingleTextField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text(hintText), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.decoration, isA<BoxDecoration>());
      final boxDecoration = container.decoration as BoxDecoration;
      expect(boxDecoration.color, backgroundColor);
    });

    testWidgets('accepts input', (WidgetTester tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      const hintText = 'Enter text';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      );

      // 텍스트 필드에 텍스트 입력
      await tester.enterText(find.byType(TextField), 'Hello');
      expect(controller.text, 'Hello');
    });

    testWidgets('applies focus', (WidgetTester tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      const hintText = 'Enter text';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      );

      // 텍스트 필드에 포커스 적용
      expect(focusNode.hasFocus, isFalse);
      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);
    });
  });
}
