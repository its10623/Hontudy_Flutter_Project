import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MascotAvatar extends StatelessWidget {
  final double size;

  const MascotAvatar({super.key, this.size = 34});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/mascot/mascot_default.svg',
      width: size,
      height: size,
    );
  }
}
