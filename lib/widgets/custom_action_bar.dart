import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_loja/screens/cart_page.dart';
import 'package:desafio_loja/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool? hasBackground;
  CustomActionBar({
    Key? key,
    this.title,
    required this.hasBackArrow,
    required this.hasTitle,
    this.hasBackground,
  }) : super(key: key);

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
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
              ),
            if (_hasTitle)
              Text(
                title ?? 'Carrinho',
                style: Constants.boldHeading,
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: _userRef
                        .doc(_firebaseServices.getUserId())
                        .collection("Cart")
                        .snapshots(),
                    builder: (context, snapshot) {
                      int _totalItems = 0;

                      if (snapshot.connectionState == ConnectionState.active) {
                        List _documents =
                            (snapshot?.data as QuerySnapshot).docs;
                        _totalItems = _documents.length;
                      }
                      return Text(
                        "$_totalItems",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    },
                  )),
            ),
          ],
        ));
  }
}
