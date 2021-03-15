import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarouselItem extends StatelessWidget {
  final String name;

  CarouselItem(this.name);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/fruits/$name.svg',
      semanticsLabel: name,
    );
  }
}
