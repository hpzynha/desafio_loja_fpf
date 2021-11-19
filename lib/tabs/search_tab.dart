import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_loja/screens/product_page.dart';
import '../constants.dart';
import 'package:desafio_loja/services/firebase_services.dart';
import 'package:desafio_loja/widgets/custom_input.dart';
import 'package:desafio_loja/widgets/product_cart.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
              child: Text(
                "Procure Aqui",
                style: Constants.regularDarktext,
              ),
            ),
          ) // se a barra de pesquisa estiver vazia
        else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy("search_string")
                .startAt([_searchString]).endAt([
              "$_searchString\ufeff"
            ]).get(), //Procurar os produtos ufeff é utilizado para procurar sem precisar colocar o nome completo do produto
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              // coleção "data" pronta pra conectar
              if (snapshot.connectionState == ConnectionState.done) {
                // Mostra a coleção dentro da listView
                return ListView(
                    padding: EdgeInsets.only(
                      top: 128,
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
        Padding(
          padding: const EdgeInsets.only(
            top: 45,
          ),
          child: CustomInput(
              hintText: "Procure Aqui",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value
                      .toLowerCase(); // Procurar pelo produto em letra minuscula
                });
              }),
        ),
      ],
    ));
  }
}
