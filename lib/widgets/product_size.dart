import 'package:flutter/material.dart';

import '../constants.dart';

class ProductSize extends StatefulWidget {
  final List productSizes;
  const ProductSize({
    Key? key,
    required this.productSizes,
  }) : super(key: key);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Text("${widget.productSizes[i]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  )),
            )
        ],
      ),
    );
  }
}
