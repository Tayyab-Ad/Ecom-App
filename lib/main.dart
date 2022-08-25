import 'dart:convert';
import 'package:e_commerce_app/assets/models/loginResponse.dart';
import 'package:e_commerce_app/assets/pages/button.dart';
import 'package:e_commerce_app/assets/pages/homePage.dart';
import 'package:e_commerce_app/assets/pages/pageSignIn.dart';
import 'package:e_commerce_app/assets/pages/pageSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'assets/models/categoryResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool state = false;
  bool isLoading = false;
  Map<String, String> signIn = {};
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginData? loginData;
  List<categoryData>? categorydata = [];

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
                    image: AssetImage("lib/assets/images/shop1.png"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,

                    //fit: BoxFit.fitWidth
                  )
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
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
                  child: Text("Welcome back !", style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w600,
                  )),
                ),
                SizedBox(height: 2),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Sign in to your account", style: TextStyle(
                      fontSize: 15, color: Color(0xFFF868889),
                    ),)
                ),
                SizedBox(height: 26),
                PageSignIn(text: "Email Address", icon: CupertinoIcons.mail, mycontroller: emailController),
                SizedBox(height: 5),
                RandomTextField(myController: passwordController, hintText: '● ● ● ● ● ● ● ●', icon1: CupertinoIcons.padlock,
                icon2: Icons.remove_red_eye_outlined, color: Colors.white),
                SizedBox(height: 15),
                Row(
                  children:  [
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                          value: state,
                          activeColor: CupertinoColors.activeBlue,
                          onChanged: (value){
                            setState(() {
                              state = value;
                            });
                          }),
                    ),
                    SizedBox(width: 10),
                    Text("Remember me", style: TextStyle(
                        color: Color(0xFFF868889), fontSize:17, fontWeight: FontWeight.w500
                    )),
                    SizedBox(width: 71),
                    Text("Forogt password", style: TextStyle(
                        color: Color(0xFFF407EC7), fontSize:17, fontWeight: FontWeight.w500
                    ))
                  ],

                ),
                SizedBox(height: 17),
                !isLoading ? GestureDetector(
                    child: Button(text: "Login"),
                  onTap: (){
                      loginUser();
                  },
                ) : CircularProgressIndicator(),
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageSignUp()));
                        },
                        child: Text(" Sign up", style: TextStyle(
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

  void loginUser() async {

    try{
      setState(() {
        isLoading = true;
      });

      var url = Uri.parse('http://ishaqhassan.com:2000/user/signin');
      var response = await http.post(url, body: {'email': emailController.text, 'password': passwordController.text });
      var responseJson = loginResponse.fromJson(jsonDecode(response.body));

      loginData = responseJson.data;
        print(loginData?.accessToken);
        if(loginData?.accessToken != null){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage(accessToken: loginData!.accessToken)));
        }
    }
    catch(e){
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }
}


