import 'package:flutter/material.dart';
import 'package:lenswear_app/util/theme_data.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key, required this.onPressed, required this.activeIndex})
      : super(key: key);

  @override
  _MyNavBarState createState() => _MyNavBarState();

  final Function(int) onPressed;
  final int activeIndex;
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: navBarShadow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyNavBarItem(
              onPressed: widget.onPressed,
              activeIndex: widget.activeIndex,
              itemIndex: 0,
              iconData: Icons.search,
              itemName: "Search",
            ),
            MyNavBarItem(
              onPressed: widget.onPressed,
              activeIndex: widget.activeIndex,
              itemIndex: 1,
              iconData: Icons.home,
              itemName: "Home",
            ),
            // MyNavBarItem(
            //   onPressed: widget.onPressed,
            //   activeIndex: widget.activeIndex,
            //   itemIndex: 2,
            //   iconData: Icons.favorite,
            //   itemName: "Favorite",
            // ),
          ],
        ),
      ),
    );
  }
}

class MyNavBarItem extends StatefulWidget {
  const MyNavBarItem(
      {Key? key,
      required this.onPressed,
      required this.activeIndex,
      required this.itemIndex,
      required this.iconData,
      required this.itemName})
      : super(key: key);

  @override
  _MyNavBarItemState createState() => _MyNavBarItemState();

  final Function(int) onPressed;
  final int activeIndex;
  final int itemIndex;
  final IconData iconData;
  final String itemName;
}

class _MyNavBarItemState extends State<MyNavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        lowerBound: 0,
        upperBound: 0.25)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();

  void _onTapUp(TapUpDetails details) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTap: () => setState(
          () {
            widget.onPressed(widget.itemIndex);
          },
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1 + _controller.value,
              child: Icon(
                widget.iconData,
                size: 35,
                color: widget.activeIndex == widget.itemIndex
                    ? accentColor
                    : secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
