import 'package:flutter/material.dart';

import '../const/const_color.dart';

class cardTitle extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  const cardTitle({super.key, required this.title, required this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
