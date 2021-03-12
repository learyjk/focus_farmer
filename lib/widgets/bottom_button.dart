import 'package:flutter/material.dart';

bottomButton({String title, Color color, VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontFamily: 'Inter', fontSize: 30),
        ),
      ),
      color: color,
      padding: EdgeInsets.all(20),
    ),
  );
}
