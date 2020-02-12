import 'dart:math';

import 'package:flutter/material.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Circles",
      home: Material(
        child: Center(
          child: Container(
            height: 320,
            width: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: CustomMultiChildLayout(
              delegate: CirclesDelegate(),
              children: <Widget>[
                ...List.generate(CirclesDelegate.circlesCount, (index) => _drawCircle(index)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawCircle(int id) => LayoutId(
        id: id,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          height: CirclesDelegate.circleSize,
          width: CirclesDelegate.circleSize,
        ),
      );
}

class CirclesDelegate extends MultiChildLayoutDelegate {
  static const circlesCount = 8;
  static const circleSize = 44.0;

  @override
  void performLayout(Size size) {
    final angleJump = 360 / circlesCount;

    for (int i = 0; i < circlesCount; i++) {
      final circleAngle = angleJump * i;
      final radians = angleToRadians(circleAngle);
      final r = size.height / 2 - circleSize;
      final centerCoordinate = size.height / 2;
      final x = r * cos(radians) + centerCoordinate - circleSize / 2;
      final y = r * sin(radians) + centerCoordinate - circleSize / 2;
      layoutChild(i, BoxConstraints(maxHeight: size.height, maxWidth: size.width));
      positionChild(i, Offset(x, y));
    }
  }

  double angleToRadians(double angle) => angle * pi / 180;

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => true;
}
