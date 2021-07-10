
import 'dart:convert';

import 'package:bamboogrove/foodinfo.dart';
import 'package:bamboogrove/payment.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CartList extends StatefulWidget {
    final Foodinfo foodinfo;
   final Userinfo userinfo;

  const CartList({Key key, this.foodinfo, this.userinfo}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  String _titlecenter = "Loading your cart";
  List _cartList = [];
  double _totalprice ;
  int qty = 1;

  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Center(
         child: Container(
           constraints:BoxConstraints.expand(),
                decoration: BoxDecoration(image:DecorationImage(
                  image:AssetImage('assets/images/background1.jpg'), 
                fit:BoxFit.cover,
                colorFilter:new ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.dstATop)),
                ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height:10),
                if (_cartList.isEmpty)
                  Flexible(child: Center(child: Text(_titlecenter)))
                else
                  Flexible(
                      child: OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 3 / 1,
                        children: List.generate(_cartList.length, (index) {
                          return Padding(
                              padding: EdgeInsets.all(1),
                              child:
                               Container(
                                  child: Card(
                                      child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      height: orientation == Orientation.portrait
                                          ? 100
                                          : 150,
                                      width: orientation == Orientation.portrait
                                          ? 100
                                          : 150,
                                      child:CachedNetworkImage(
                                  imageUrl:
                                      "https://javathree99.com/s271490/bamboogrove/images/product/${_cartList[index]['foodid']}.png",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                    ),
                                  ),
                                  Container(
                                      height: 100,
                                      child: VerticalDivider(color: Colors.cyan.shade700)),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_cartList[index]['foodname'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  _foodQty(index, "remove");
                                                },
                                              ),
                                              Text(_cartList[index]['foodqty'],
                                              style:
                                              TextStyle(
                                              color: Colors.red,
                                              fontSize: 18)),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  _foodQty(index, "add");
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "RM " +
                                                (int.parse(_cartList[index]
                                                            ['foodqty']) *
                                                        double.parse(
                                                            _cartList[index]
                                                                ['foodprice']))
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                             _deleteCartDialog(index);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))));
                        }));
                  })),
                Container(
                  color: Colors.grey,
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 5),
                        Divider(
                          color: Colors.blueGrey[400],
                          height: 1,
                          thickness: 10.0,
                        ),
                        Text(
                          "TOTAL RM " + _totalprice.toStringAsFixed(2),
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Payment(userinfo:widget.userinfo)));
                          },
                          child: Text("CHECKOUT"),
                          style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400]
                      ),)
                      ],  
                    ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

   _loadMyCart() {
   _totalprice = 0;

     print(widget.userinfo.email);
       http.post(
        Uri.parse(
            "https://javathree99.com/s271490/bamboogrove/php/load_cart.php"),
        body: {
          "email":widget.userinfo.email,

        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No data";
        return;
      } else {
        setState(() {
          var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
        _titlecenter = "Contain Data";
          for(int index = 0; index < _cartList.length; index++){
            _totalprice = double.parse(_cartList[index]['total_price']) +_totalprice;
          }
        });

        print(_cartList);
      }
    });
   
  }

  Future<void> _foodQty(int index, String s) async {
    qty = int.parse(_cartList[index]['foodqty']);

    if(s == "remove"){
      if(qty != 0){
      qty--;
      }
    } else {
      qty++;
    }

     print(qty);
     
  http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/update_cart.php"),
        body: {
          "foodid":_cartList[index]['foodid'],
          "email": widget.userinfo.email,
          "foodqty": qty.toString(),

        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
            _loadMyCart();
       
      } else {
        Fluttertoast.showToast(
            msg: "Failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
    
      }

    });
    return;

  }

  Future<void> _deleteCart(int index) async {

   http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/delete_cart.php"),
        body: {
          "foodid":_cartList[index]['foodid'],
          "email": widget.userinfo.email,

        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
            _loadMyCart();
       
      } else {
        Fluttertoast.showToast(
            msg: "Failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
    
      }

    });
    return;
   
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }


  }