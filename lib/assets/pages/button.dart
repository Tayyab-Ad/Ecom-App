import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  String text = "";
  //var cont;

  Button({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xFFAEDC81),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Text(text, style: TextStyle(
            color: Colors.white, fontSize:17, fontWeight: FontWeight.w600
        ))
    );
  }
}
