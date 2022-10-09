import 'package:aniline/constant.dart';
import 'package:flutter/material.dart';

class AnilineButton extends StatelessWidget {
  const AnilineButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  final VoidCallback? onPressed;

  final String text;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: kPrimaryColor,
      onPressed: onPressed,
      shape: const StadiumBorder(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(color: kTextColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
