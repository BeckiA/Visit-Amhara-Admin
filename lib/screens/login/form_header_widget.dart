import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  FormHeader({
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
          // textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
