import 'package:flutter/material.dart';

class AnilineCatalogCard extends StatelessWidget {
  const AnilineCatalogCard({
    Key? key,
    required this.title,
    required this.cover,
    required this.eps,
    required this.genre,
    this.height = 200,
    this.width = double.infinity,
  }) : super(key: key);

  final double width;
  final double height;
  final String title;
  final String cover;
  final String genre;
  final int eps;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(cover, fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey[100],
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            shadows: const [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 5.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 5),
                    AnilineCatalogCardLabel(text: genre),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: AnilineCatalogCardLabel(text: 'Eps $eps')),
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
        color: Colors.grey[200]?.withOpacity(0.90),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
