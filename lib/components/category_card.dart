import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.title,
    required this.tag,
    required this.image,
    required this.textColor,
    required this.backgroundColor,
    this.press,
  }) : super(key: key);

  final String title, tag;
  final AssetImage image;
  final VoidCallback? press;
  final Color textColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(26),
              image: DecorationImage(
                  image: image, alignment: Alignment.topRight, scale: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18.0,
                color: textColor,
              ),
            ],
          ),
        ));
  }
}
