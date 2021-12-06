import 'package:flutter/material.dart';
import 'package:hackaton/constants/constants.dart';

class FormInputFieldWithIconClick extends StatelessWidget {
  FormInputFieldWithIconClick({
    this.labelTextPrefix = "",
    required this.labelText,
    this.iconPrefix,
    required this.onTap,
    this.marginButtom = 15,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.paddingButtom = 13,
    this.paddingTop = 13,
    this.paddingLeft = 10,
    this.paddingRight = 10,
    this.enable = true,
  });

  final IconData? iconPrefix;
  final String labelTextPrefix;
  final String labelText;
  final void Function()? onTap;
  final double marginButtom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;
  final double paddingButtom;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          border: enable
              ? Border.all(color: AppThemes.orange)
              : Border.all(color: AppThemes.orange.withAlpha(50)),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(
          bottom: marginButtom,
          top: marginTop,
          left: marginLeft,
          right: marginRight,
        ),
        padding: EdgeInsets.only(
          bottom: paddingButtom,
          top: paddingTop,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            Icon(
              iconPrefix,
              color: enable ? Colors.grey : Colors.grey.withAlpha(90),
            ),
            Text(
              labelTextPrefix,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            Text(
              labelText,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
