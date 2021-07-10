import 'dart:convert';
import 'package:bamboogrove/myprofile.dart';
import 'package:bamboogrove/searchscreen.dart';
import 'package:bamboogrove/cart.dart';
import 'package:bamboogrove/cartlist.dart';
import 'package:bamboogrove/foodinfo.dart';
import 'package:bamboogrove/myproduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bamboogrove/login_screen.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:http/http.dart' as http;


class Mainscreen extends StatefulWidget {
   final Foodinfo foodinfo;
   final Userinfo userinfo;
   

  const Mainscreen({Key key, this.userinfo, this.foodinfo}) : super(key: key);

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
   double screenHeight, screenWidth;
  List _productList;
  String _titlecenter = "Loading....";
  TextEditingController searchc = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadingProduct();
  }

  @override
  Widget build(BuildContext context) {
     screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text("BAMBOO GROVE"),
          backgroundColor:Colors.cyan.shade700,
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => SearchScreen()));
              },
            )
          ],
          ),
          drawer:Drawer(
            child:ListView(
              children:[
                UserAccountsDrawerHeader(
                  decoration:BoxDecoration(color:Colors.cyan[700]),
                  accountName: Text(widget.userinfo.username.substring(0,1).toUpperCase()
                  +widget.userinfo.username.substring(1),
                  style:TextStyle(fontSize:20)),
                 accountEmail: Text(widget.userinfo.email,style:TextStyle(fontSize:15),),
                 currentAccountPicture:CircleAvatar(
                   backgroundColor:Theme.of(context).platform == TargetPlatform.android
                   ?Colors.white
                   :Colors.cyan[800],
                child:Text(widget.userinfo.email.toString().substring(0,1).toUpperCase(),
                style:TextStyle(fontSize:40),)
                 ),
                 ),

            ListTile(
              title:Text("HOME"),
              onTap:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mainscreen(userinfo:widget.userinfo)));
              }
            ),
            ListTile(
              title:Text("MY PROFILE"),
              onTap:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Myprofile(userinfo:widget.userinfo)));
              }
            ),
            ListTile(
              title:Text("MY PRODUCT"),
                onTap:(){
                Navigator.push
                  (context,MaterialPageRoute(builder:
                  (content)=>Myproduct())
                  );
              }
            ),
            ListTile(
              title:Text("CART"),
              onTap:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartList(userinfo:widget.userinfo)));
              }
            ),
            ListTile(
              title:Text("LOG OUT" ),
              onTap:(){
                Navigator.push
                  (context,MaterialPageRoute(builder:
                  (content)=>Loginscreen())
                  );
              })
           ])),
           body: Center(
            child: Container(
              constraints:BoxConstraints.expand(),
                        decoration: BoxDecoration(image:DecorationImage(
                        image:AssetImage('assets/images/background2.jpg'), 
                        fit:BoxFit.cover,
                         colorFilter:new ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop)),
                         ),
              child: Column(
          children: [
              _productList == null
                  ? Flexible(child: Center(child: Text(_titlecenter)))
                  : Flexible(
                      child: Center(
                          child: Container(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (screenWidth / screenHeight) / 0.9,
                          children: List.generate(_productList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.all(5),
                                child: Card(
                                    child: InkWell(
                                       onTap: (){
                                      _addtocart(index);
                                      },
                                    child: SingleChildScrollView(
                                  child: Column(
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://javathree99.com/s271490/bamboogrove/images/product/${_productList[index]['foodid']}.png",
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 20, 0, 0),
                                              child: Text(
                                                  _productList[index]['foodname'],
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 0),
                                            child: Text(
                                              "RM " +
                                                  _productList[index]['foodprice'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ]),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 5, 5, 0),
                                              child: Text(
                                                "" + _productList[index]['foodcat'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                  ),
                                ),
                                    )));
                          }),
                        ),
                      )),
                    )
          ],
        )),
           ),
        floatingActionButton:FloatingActionButton(
                 backgroundColor: Colors.blueGrey[400],
              
              onPressed: () {
               Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartList(userinfo:widget.userinfo)));
               },
                child:Icon(Icons.add_shopping_cart,
                color: Colors.white,
                size:25),

              )
      )
        );
  }

  void _loadingProduct() {
    http.post(
        Uri.parse(
            "https://javathree99.com/s271490/bamboogrove/php/loadproduct.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No data";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        _titlecenter = "Contain Data";
        setState(() {});
        print(_productList);
      }
    });
  }

  void _addtocart(int index) {
    print(index);
       Foodinfo foodinfo = new Foodinfo(
      foodid: _productList[index]['foodid'],
      foodcat: _productList[index]['foodcat'],
      foodname: _productList[index]['foodname'],
      foodprice: _productList[index]['foodprice']
    );
    Navigator.push(context,
      MaterialPageRoute(builder: 
      (context) => Cart(foodinfo:foodinfo,userinfo:widget.userinfo)));
    print(widget.userinfo.email);
  }
}
