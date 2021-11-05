import 'package:flutter/material.dart';

class LabelIcon extends StatelessWidget {
  LabelIcon({
    required this.textLabel,
    this.iconL,
    this.iconR,
  });
  final String textLabel;
  final IconData? iconL;
  final IconData? iconR;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (iconL != null)
            WidgetSpan(
              child: Icon(iconL, size: 20),
            ),
          TextSpan(
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
            text: textLabel,
          ),
          if (iconR != null)
            WidgetSpan(
              child: Icon(iconR, size: 20),
            ),
        ],
      ),
    );
  }
}
