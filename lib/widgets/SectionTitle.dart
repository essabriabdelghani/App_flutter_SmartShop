import 'package:flutter/material.dart';

class Sectiontitle extends StatelessWidget {
  final String sectiontitle;
  const Sectiontitle({super.key, required this.sectiontitle});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 5, height: 25, color: Colors.black),

        SizedBox(width: 15),

        Text(
          sectiontitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
