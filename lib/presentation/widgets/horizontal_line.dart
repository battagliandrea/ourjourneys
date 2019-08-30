import 'package:flutter/material.dart';
import 'package:our_journeys/presentation/utils/dimens.dart';

class HorizontalLine extends StatelessWidget {

  const HorizontalLine({
    Key key,
    this.color = Colors.black,
    this.height = 5.0,
    this.width = 100.0,
    this.paddingStart = 0.0,
    this.paddingTop = 0.0,
    this.paddingEnd = 0.0,
    this.paddingBottom = 0.0,
    this.radiusTopLeft = const Radius.circular(0),
    this.radiusTopRight = const Radius.circular(0),
    this.radiusBottomRight = const Radius.circular(0),
    this.radiusBottomLeft = const Radius.circular(0),
  }) : super(key: key);


  final Color color;
  final double height;
  final double width;
  final Radius radiusTopLeft;
  final Radius radiusBottomLeft;
  final Radius radiusTopRight;
  final Radius radiusBottomRight;
  final double paddingStart;
  final double paddingTop;
  final double paddingBottom;
  final double paddingEnd;

  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: EdgeInsets.only(left: paddingStart, top: paddingTop, right: paddingEnd, bottom: paddingBottom),
      height: height,
      width: width,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.only(
            topLeft: radiusTopLeft,
            bottomLeft: radiusBottomLeft,
            topRight: radiusTopRight,
            bottomRight: radiusBottomLeft
        ),
      ),
    );
  }




}