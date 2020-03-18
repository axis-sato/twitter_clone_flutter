import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';

void main() {
  Widget wrapped(Like like) {
    return MaterialApp(
      home: Scaffold(
        body: like,
      ),
    );
  }

  testWidgets('like count', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapped(
        Like(
          like: 5,
          isLiked: true,
          onPressed: (isLiked) {},
        ),
      ),
    );

    final likeCountFinder = find.text('5');
    expect(likeCountFinder, findsOneWidget);
  });

  group('icon', () {
    testWidgets('liked', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapped(
          Like(
            like: 5,
            isLiked: true,
            onPressed: (isLiked) {},
          ),
        ),
      );

      final iconFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Icon &&
            widget.icon == Icons.favorite &&
            widget.color == Colors.pink,
      );
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('not liked', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapped(
          Like(
            like: 5,
            isLiked: false,
            onPressed: (isLiked) {},
          ),
        ),
      );

      final iconFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Icon &&
            widget.icon == Icons.favorite_border &&
            widget.color == Colors.grey,
      );
      expect(iconFinder, findsOneWidget);
    });
  });

  group('tap like', () {
    testWidgets('unliked -> liked', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapped(
          Like(
            like: 5,
            isLiked: false,
            onPressed: (isLiked) => print(isLiked),
          ),
        ),
      );

      expect(() => tester.tap(find.byType(IconButton)), prints('false\n'));
    });

    testWidgets('liked -> unliked', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapped(
          Like(
            like: 5,
            isLiked: true,
            onPressed: (isLiked) => print(isLiked),
          ),
        ),
      );

      expect(() => tester.tap(find.byType(IconButton)), prints('true\n'));
    });
  });
}
