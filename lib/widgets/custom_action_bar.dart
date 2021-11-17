import 'package:flutter/material.dart';

import '../constants.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool? hasBackground;
  const CustomActionBar({
    Key? key,
    this.title,
    required this.hasBackArrow,
    required this.hasTitle,
    this.hasBackground,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow;
    bool _hasTitle = hasTitle;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 0),
                )
              : null),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 42,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/images/back_arrow.png"),
                color: Colors.white,
                width: 16,
                height: 16,
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
