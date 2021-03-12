import 'package:flutter/material.dart';
import 'package:focus_farmer/providers/stack_item.dart';

class StackItemWidget extends StatelessWidget {
  final StackItem item;

  StackItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    double fruitSize = MediaQuery.of(context).size.width * 0.05;

    return Positioned(
      left: item.xCoord,
      top: item.yCoord,
      child: RichText(
        text: TextSpan(
          text: '',
          children: [
            TextSpan(
              text: item.value,
              style: TextStyle(fontSize: fruitSize),
            ),
          ],
        ),
      ),
    );
  }
}
