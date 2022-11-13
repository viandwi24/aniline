import 'package:aniline/constant.dart';
import 'package:aniline/screens/main/tabs/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:unicons/unicons.dart';

class AnilineBottomNavbar extends StatefulWidget {
  const AnilineBottomNavbar({super.key});

  @override
  State<AnilineBottomNavbar> createState() => _AnilineBottomNavbarState();
}

class _AnilineBottomNavbarState extends State<AnilineBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AnilineScaffoldWithNavbar extends StatefulWidget {
  const AnilineScaffoldWithNavbar(
      {super.key, this.builder, required this.pages});

  final Widget Function(BuildContext context, int index)? builder;

  final List<List> pages;

  @override
  State<AnilineScaffoldWithNavbar> createState() =>
      _AnilineScaffoldWithNavbarState();
}

class _AnilineScaffoldWithNavbarState extends State<AnilineScaffoldWithNavbar> {
  int _selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          var currW = widget.builder is Function
              ? widget.builder!(context, _selectedIndex)
              : null;
          if (currW is Widget) return currW;

          // build
          var page = widget.pages[_selectedIndex];
          if (page[1] is Widget) return page[1];

          setState(() {
            _selectedIndex = 0;
          });

          return widget.pages[0][1];
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // for each widget.pages
            for (var page in widget.pages)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = widget.pages.indexOf(page);
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        page[2],
                        size: 32,
                        color: _selectedIndex == widget.pages.indexOf(page)
                            ? kPrimaryColor
                            : kTextColor.withOpacity(0.5),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedIndex == widget.pages.indexOf(page)
                              ? kPrimaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
