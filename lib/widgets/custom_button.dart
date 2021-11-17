import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final bool? outlineBtn;
  final bool? isLoading;

  CustomBtn({
    Key? key,
    this.text,
    required this.onPressed,
    this.outlineBtn,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logica para trocar as cores do botão
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    // eu usei o container ao invés do FlatButton ou Material Button
    // por que me dá mais liberdade para customizar o botão
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          // Se o botão _outlineBtn for verdadeiro usar essa configuração
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? 'Aqui',
                  style: TextStyle(
                    fontSize: 16,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
