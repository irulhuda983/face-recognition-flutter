import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAbsensiButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddAbsensiButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF130160),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(153, 171, 198, 0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          'assets/icons/fingerprint.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
