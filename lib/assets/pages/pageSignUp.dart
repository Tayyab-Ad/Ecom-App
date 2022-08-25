import 'package:e_commerce_app/assets/pages/button.dart';
import 'package:e_commerce_app/assets/pages/pageSignIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PageSignUp extends StatelessWidget {
   PageSignUp({Key? key}) : super(key: key);

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneNumCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 17, top: 68),
              //width: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/shop2.png"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,

                    //fit: BoxFit.fitWidth
                  )
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  SizedBox(width: 123),
                  Text("Welcome", style: TextStyle(
                      color: Colors.white, fontSize: 18
                  ),)
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(15),
              color: Color(0xFFF4F5F9),
            ),
            alignment: Alignment.topLeft,

            padding: EdgeInsets.only(left: 16, right: 17, top: 30, bottom: 45),

            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Create account", style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w600,
                  )),
                ),
                SizedBox(height: 2),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Quickly create account", style: TextStyle(
                      fontSize: 15, color: Color(0xFFF868889),
                    ),)
                ),
                SizedBox(height: 26),
                PageSignIn(text: "Email Address", icon: CupertinoIcons.mail, mycontroller: emailCtrl),
                SizedBox(height: 5),
                PageSignIn(text: "Phone number", icon: CupertinoIcons.phone, mycontroller: phoneNumCtrl),
                SizedBox(height: 5),
                RandomTextField(myController: passwordCtrl, hintText: '● ● ● ● ● ● ● ●', icon1: CupertinoIcons.padlock, icon2: Icons.remove_red_eye_outlined, color: Colors.white),
                SizedBox(height: 17),
                GestureDetector(
                  onTap: (){
                    CreateUser();
                  },
                    child: Button(text: "Signup")),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account ?", style: TextStyle(
                        color: Color(0xFF868889), fontSize:17, fontWeight: FontWeight.w300
                    )),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(" Login", style: TextStyle(
                          color: Colors.black, fontSize:17, fontWeight: FontWeight.bold
                      )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void CreateUser() async{

    try{
      var url = Uri.parse('http://ishaqhassan.com:2000/user');
      var response = await http.post(url, body: {'email': emailCtrl.text, 'phone': phoneNumCtrl.text, 'password': passwordCtrl.text });
      //var responseJson = loginResponse.fromJson(jsonDecode(response.body));
      print(response.body);
    }
    catch(e){
      print(e);
    }
  }
}
