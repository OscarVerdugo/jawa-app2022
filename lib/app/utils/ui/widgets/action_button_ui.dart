import 'package:flutter/material.dart';

class UIActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function() onTap;
  const UIActionButton(
      {Key? key, required this.color, required this.icon, required this.onTap})
      : super(key: key);

  //UNUSED
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      color: Colors.amberAccent,
      child: InkWell(
        onTap: onTap,
        child: Container(
            height: 10,
            width: 50,
            padding: EdgeInsets.all(8),
            child: Icon(icon, color: color)),
      ),
    );
  }
}
