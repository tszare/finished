import 'dart:math';
import 'package:flutter/material.dart';

class CirclePaint extends StatelessWidget {
  CirclePaint({
    this.strokeWidth = 2.0,
    @required this.radius,
    @required this.color,
    this.totalAngle = 2 * pi,
    this.value
  });

  ///粗细
  final double strokeWidth;

  /// 圆的半径
  final double radius;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;
  /// 渐变色数组
  final Color color;


  @override
  Widget build(BuildContext context) {
    double _offset = .0;

    var _color = color;
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            value: value,
            total: totalAngle,
            radius: radius,
            color: _color,
          )
      ),
    );
  }
}

//实现画笔
class _GradientCircularProgressPainter extends CustomPainter {

  _GradientCircularProgressPainter({
    this.strokeWidth: 10.0,
    this.radius,
    this.total = 2 * pi,

    @required this.color,
    this.value
  });

  final double strokeWidth;
  final double value;
  final Color color;
  final double total;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {


    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;

    var circlePaint =Paint()
      ..style=PaintingStyle.fill
      ..strokeWidth=strokeWidth/2*1.5*0.3
      ..color=color;


    final double dox = radius+(2*strokeWidth)*cos(_value);
    final double doy = radius+(2*strokeWidth)*sin(_value);

    canvas.drawCircle(
        Offset(dox,doy),
        190,
        circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;


}