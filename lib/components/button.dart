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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        width: double.infinity,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.merge(
                const TextStyle(
                  color: kTextLightColor,
                ),
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
