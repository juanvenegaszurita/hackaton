import 'package:flutter/material.dart';

class CardGeneric extends StatelessWidget {
  CardGeneric({
    required this.body,
    this.onTap,
    this.color,
    this.width = 100,
    this.height = 100,
    this.paddingBottom: 10,
    this.paddingLeft: 10,
    this.paddingRight: 10,
    this.paddingTop: 10,
  });
  final Widget body;
  final void Function()? onTap;
  final Color? color;
  final double width;
  final double height;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        color: color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          splashColor: color != null
              ? color!.withAlpha(300)
              : Colors.grey.withAlpha(300),
          borderRadius: BorderRadius.circular(15.0),
          hoverColor:
              color != null ? color!.withAlpha(50) : Colors.grey.withAlpha(50),
          focusColor:
              color != null ? color!.withAlpha(80) : Colors.grey.withAlpha(80),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: paddingBottom,
              left: paddingLeft,
              right: paddingRight,
              top: paddingTop,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
