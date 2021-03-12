import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String textToDisplay;

  CarouselItem(this.textToDisplay);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'hello',
        children: [
          TextSpan(
            text: textToDisplay,
            style: TextStyle(fontSize: 100),
          ),
        ],
      ),
    );
  }
}
