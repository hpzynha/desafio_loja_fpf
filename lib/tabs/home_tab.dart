import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_loja/screens/product_page.dart';
import 'package:desafio_loja/widgets/custom_action_bar.dart';
import 'package:desafio_loja/widgets/product_cart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              // Collection data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                    padding: EdgeInsets.only(
                      top: 108,
                      bottom: 12,
                    ),
                    children: snapshot.data!.docs.map((document) {
                      return ProductCart(
                        productId: document.id,
                        imageUrl: document['images'][0],
                        title: document['name'],
                        price: "R\$ ${document['price']}",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  productId: document.id,
                                ),
                              ));
                        },
                      );
                    }).toList());
              }
              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasTitle: true,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
