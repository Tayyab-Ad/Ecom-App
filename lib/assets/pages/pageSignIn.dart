import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class PageSignIn extends StatelessWidget {

  String text = "";
  IconData icon ;
  //Map<String, String> data;
  var mycontroller;

  PageSignIn({Key? key, required this.text, required this.icon, required this.mycontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 28),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,

            icon: Icon(icon)
        ),
        style: TextStyle(
          fontWeight: FontWeight.w500
        ),
        controller: mycontroller,
      ),
    );
  }
}

class RandomTextField extends StatelessWidget {
   RandomTextField({Key? key, required this.myController,required this.hintText,
     required this.icon1,  required this.icon2,required this.color}) : super(key: key);

  var myController;
  String? hintText;
  IconData? icon1;
  IconData? icon2;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 28),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child:  TextField(
                controller: myController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    icon: Icon(icon1)
                ),
              ),
            ),
          ),
          Icon(icon2, color: Color(0xFF868889)),
          SizedBox(width: 25)
        ],

      )
          //Icon(CupertinoIcons.padlock, color: Color(0xFF868889)),

    );
  }
}

