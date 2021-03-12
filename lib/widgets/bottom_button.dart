import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;

  BottomButton({this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        color: color,
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
