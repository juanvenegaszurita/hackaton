import 'package:flutter/material.dart';

class Qualification extends StatelessWidget {
  Qualification({
    required this.qualification,
  });
  final int qualification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...List.generate(qualification, (index) => Icon(Icons.star)),
        ...List.generate(5 - qualification, (index) => Icon(Icons.star_border)),
      ],
    );
  }
}
