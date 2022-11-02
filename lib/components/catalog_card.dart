import 'package:aniline/constant.dart';
import 'package:flutter/material.dart';

class AnilineCatalogCard extends StatefulWidget {
  const AnilineCatalogCard({
    Key? key,
    required this.title,
    required this.cover,
    this.labelBottom,
    this.labelTop,
    this.content,
    this.height = 200,
    this.width = double.infinity,
  }) : super(key: key);

  final double width;
  final double height;
  final String title;
  final String cover;
  final String? labelBottom;
  final String? labelTop;
  final String? content;

  @override
  State<AnilineCatalogCard> createState() => _AnilineCatalogCardState();
}

class _AnilineCatalogCardState extends State<AnilineCatalogCard> {
  bool errCoverImg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: Image.network(
            widget.cover,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              setState(() {
                errCoverImg = true;
              });

              return Container(
                width: 100,
                height: 100,
                color: Colors.grey,
              );
            },
          ).image,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Stack(
          children: [
            if (widget.labelTop != null) ...[
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  child:
                      AnilineCatalogCardLabel(text: widget.labelTop as String),
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: kTextLightColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (widget.content != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Text(
                        widget.content as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: kTextLightColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  if (widget.labelBottom != null) ...[
                    AnilineCatalogCardLabel(text: widget.labelBottom as String),
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
        color: kPrimaryColor.withOpacity(0.90),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: kTextLightColor,
        ),
      ),
    );
  }
}
