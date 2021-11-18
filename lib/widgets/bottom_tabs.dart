import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  const BottomTabs({
    Key? key,
    required this.selectedTab,
    required this.tabPressed,
  }) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            spreadRadius: 1,
            blurRadius: 30,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: "assets/images/tab_home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_saved.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabBtn(
            // Erro Concertar o Botao de logout antes de enviar
            imagePath: "assets/images/tab_logout.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              // Logout
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatefulWidget {
  final String? imagePath;
  final bool? selected;
  final VoidCallback onPressed;
  const BottomTabBtn({
    Key? key,
    this.imagePath,
    this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<BottomTabBtn> createState() => _BottomTabBtnState();
}

class _BottomTabBtnState extends State<BottomTabBtn> {
  @override
  Widget build(BuildContext context) {
    bool _selected = widget.selected ?? false;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 28,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color:
                _selected ? Theme.of(context).accentColor : Colors.transparent,
            width: 2,
          )),
        ),
        child: Image(
          image: AssetImage(
            widget.imagePath ?? "assets/images/tab_home.png",
          ),
          width: 26,
          height: 26,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
