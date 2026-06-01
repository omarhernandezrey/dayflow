import 'package:flutter_test/flutter_test.dart';
import 'package:dayflow/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DayFlowApp());
    expect(find.text('DayFlow'), findsWidgets);
  });
}
