import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon({
    required this.controller,
    required this.labelText,
    required this.validator,
    this.iconPrefix,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines,
    required this.onChanged,
    required this.onSaved,
    this.enabled = true,
    this.marginButtom = 15,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
  });

  final TextEditingController controller;
  final IconData? iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final bool enabled;
  final double marginButtom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: marginButtom,
        top: marginTop,
        left: marginLeft,
        right: marginRight,
      ),
      child: TextFormField(
        enabled: enabled,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: iconPrefix != null ? Icon(iconPrefix) : null,
          labelText: labelText,
        ),
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        validator: validator,
      ),
    );
  }
}
