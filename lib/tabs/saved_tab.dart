import 'package:desafio_loja/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text(
              'Produtos Salvos',
            ),
          ),
          CustomActionBar(
            title: "Saved",
            hasTitle: true,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
