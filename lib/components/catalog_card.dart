import 'package:aniline/constant.dart';
import 'package:flutter/material.dart';

class AnilineCatalogCard extends StatelessWidget {
  const AnilineCatalogCard({
    Key? key,
    required this.title,
    required this.cover,
    this.eps,
    this.genre,
    this.height = 200,
    this.width = double.infinity,
  }) : super(key: key);

  final double width;
  final double height;
  final String title;
  final String cover;
  final String? genre;
  final int? eps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(cover),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Stack(
          children: [
            if (eps != null && eps is int) ...[
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  child: AnilineCatalogCardLabel(text: 'Eps $eps'),
                ),
              ),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (genre != null) ...[
                    AnilineCatalogCardLabel(text: genre as String),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnilineCatalogCardLabel extends StatelessWidget {
  const AnilineCatalogCardLabel({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: kBackgroundColor.withOpacity(0.90),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
