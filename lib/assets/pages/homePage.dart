import 'dart:convert';

import 'package:e_commerce_app/assets/models/categoryResponse.dart';
import 'package:e_commerce_app/assets/models/productResponse.dart';
import 'package:e_commerce_app/assets/pages/pageSignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {

  String? accessToken;
  homePage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Products(token: widget.accessToken),
      theme: ThemeData(primarySwatch: Colors.grey
      ),
    );
  }
}

class Products extends StatefulWidget {

  String? token;
  Products({Key? key, this.token}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  final List<String> item = [
    "http://ishaqhassan.com:2000/assets/images/categories/vegs.png",
    "http://ishaqhassan.com:2000/assets/images/categories/fruits.png",
    "http://ishaqhassan.com:2000/assets/images/categories/beverage.png",
    "http://ishaqhassan.com:2000/assets/images/categories/grocery.png",
    "http://ishaqhassan.com:2000/assets/images/categories/oil.png",
    "http://ishaqhassan.com:2000/assets/images/categories/household.png"

  ];

  var searchCtrl = TextEditingController();
  List<String> colorId  = [];
  bool check = false;
  List<categoryData>? categoryItem;
  List<ProductData>? productItem;
  bool isLoading = false;
  List cartItems = [];

  @override
  void initState(){
    super.initState();
    getAllItems(widget.token);
  }

  getAllItems(String? token) async {
    setState(() {
      isLoading = true;
    });

    try {
      var categoryUrl = Uri.parse('http://ishaqhassan.com:2000/category');
      var catResponse = await http.get(
          categoryUrl, headers: {'Authorization': "Bearer $token"});
      var categoryJSON = CategoryResponse.fromJson(
          jsonDecode(catResponse.body));
      categoryItem = categoryJSON.data;

      var productUrl = Uri.parse('http://ishaqhassan.com:2000/product');
      var prodResponse = await http.get(
          productUrl, headers: {'Authorization': "Bearer ${token}"});
      var productJSON = ProductResponse.fromJson(jsonDecode(prodResponse.body));
      productItem = productJSON.data;
    }
    catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: !isLoading ? Container(
          padding: EdgeInsets.only(left: 17, right: 17, top: 50),

          child: Column(
            children: [
              RandomTextField(myController: searchCtrl, hintText: 'Search keywords..', icon1: Icons.search,
                  icon2: Icons.tune, color: Color(0xFFF4F5F9)),
              Expanded(
                child: Container(
                  //color: Color(0xFFF4F5F9),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Image.asset('lib/assets/images/unsplash1.png')
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Categories", style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18
                            )),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.arrow_forward_ios)),
                            )
                          ],
                        ),
                        SizedBox(height: 17),

                        Container(
                          height:78,

                          child: ListView.separated(
                            itemCount: categoryItem!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(makeColor(categoryItem![index].color!)).withOpacity(0.1),
                                        //color: Color(0xFF10d0e0).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 10, color: Colors.transparent)

                                    ),

                                    width: 52,
                                    height: 52,
                                    child: Image.network(item[index]),
                                  ),
                                  SizedBox(height: 11),
                                  Text(categoryItem![index].title!, style: TextStyle(color: Color(0xFF868889))),
                                ],
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 12); },
                          )
                          ,
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(

                            children: [
                              Text("Featured products", style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18
                              )),
                              Expanded(
                                child: Container(

                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.arrow_forward_ios)
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          //width: 100,
                          //height: 600,

                            color: Color(0xFFF4F5F9),
                            alignment: Alignment.topCenter,

                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: (1/1.22),
                                children: List.generate(6, (index) {
                                  return Container(
                                    //height: 220,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                          //color: Colors.blueAccent,
                                            padding: EdgeInsets.only(top: 9, right: 9),
                                            alignment: Alignment.topRight,
                                            height: 21,
                                            child: Icon(CupertinoIcons.heart)

                                        ),
                                        Container(
                                          width: 84,
                                          height: 84,
                                          decoration: BoxDecoration(
                                              color: Color(makeColor(productItem![index].color!)).withOpacity(0.3),
                                              shape: BoxShape.circle
                                          ),
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.network(productItem![index].image!,fit: BoxFit.fill),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          //height: 18,
                                          child: Text("\$"+productItem![index].price!.toString()),
                                        ),
                                        Container(
                                          //height: 23,
                                          child: Text(productItem![index].title!, style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.w600
                                          ),),
                                        ),
                                        Container(
                                          //height: 23,
                                          child: Text(productItem![index].unit!),
                                        ),
                                        SizedBox(height: 11),
                                        Container(
                                          height: 1,
                                          color: Color(0xFFF4F5F9),
                                        ),
                                        cartItems.contains(index)? Container(
                                          //padding: EdgeInsets.all(8),
                                          height: 41.6,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 15),
                                              Icon(Icons.remove, color: Color(0xFF6CC51D)),
                                              SizedBox(width: 40),
                                              Text("1", style: TextStyle(
                                                fontWeight: FontWeight.w500
                                              ),),
                                              SizedBox(width: 40),
                                              Icon(Icons.add, color: Color(0xFF6CC51D))
                                            ],
                                          ),
                                        ) : GestureDetector(
                                          child: Container(
                                            height: 41.6,
                                            //color: Colors.grey,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 35),
                                                  Icon(Icons.shopping_bag_outlined, color: Color(0xFF6CC51D),),
                                                  SizedBox(width: 9),
                                                  Text("Add to cart", style: TextStyle(
                                                      fontWeight: FontWeight.w500
                                                  ),)
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              cartItems.add(index);
                                              print(index);
                                            });
                                          },
                                        ),

                                      ],
                                    ),
                                  );
                                })
                            ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ): Center(child: Container(child: CircularProgressIndicator()))
    );
  }




}




int makeColor(String c){

  String temp;
  int col;

  temp = c.replaceAll('#', '');
  temp = "0xFF"+temp;
  col = int.parse(temp);

  return col;
}


