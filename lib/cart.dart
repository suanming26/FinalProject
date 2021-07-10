
import 'package:bamboogrove/cartlist.dart';
import 'package:bamboogrove/foodinfo.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class Cart extends StatefulWidget {
   final Foodinfo foodinfo;
   final Userinfo userinfo;

 const Cart({Key key, this.foodinfo,this.userinfo}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
   double screenHeight, screenWidth;
   int food = 0;
   int foods = 0;
   double total = 0;

  TextEditingController foodC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

      
                return Scaffold(
                  appBar: AppBar(
                      title: Text('Add Product To Cart'),
                      backgroundColor: Colors.cyan.shade700,
                      actions: [
                        IconButton(icon:Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartList(userinfo:widget.userinfo)));
                    // print(widget.userinfo.email);
                        }
                        )
                      ],
                    ),
                    body: Center(
                      child: Container(
                        constraints:BoxConstraints.expand(),
                        decoration: BoxDecoration(image:DecorationImage(
                        image:AssetImage('assets/images/background2.jpg'), 
                        fit:BoxFit.cover,
                         colorFilter:new ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.dstATop)),
                         ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                            Container(
                            child: CachedNetworkImage(
                              
                                  imageUrl:
                                      "https://javathree99.com/s271490/bamboogrove/images/product/${widget.foodinfo.foodid}.png",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                 margin:EdgeInsets.fromLTRB(20,0,20,0),
                                  decoration: BoxDecoration(color: Colors.cyan.shade100),
                                child:Column(
                                  children: [
                                     ListTile( 
                                leading: Icon(Icons.chrome_reader_mode),
                                title:Text(
                                  widget.foodinfo.foodname,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Food Name",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                 ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                             ListTile( 
                                leading: Icon(Icons.money),
                                title:Text("RM "+
                                  widget.foodinfo.foodprice,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: Text("Food Price",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                             ListTile( 
                                leading: Icon(Icons.category),
                                title:Text(
                                  widget.foodinfo.foodcat,
                                  style:TextStyle(fontSize:20,
                                  fontWeight: FontWeight.bold)),
                                  subtitle: Text("Food Category",
                                  style:TextStyle(fontSize:15,
                                  fontWeight: FontWeight.bold)),
                                  ),
                             Padding(
                               padding:const EdgeInsets.fromLTRB(15, 0, 20, 0),
                               child:Divider(
                                 color:Colors.black,
                               ),
                             ),
                              ],
                  )
                ),
                  ]),
                  ),
                      ),
                    ),
                floatingActionButton: Visibility(
            
            child: FloatingActionButton.extended(
              label: Text(
                'Add To Cart',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _addfood();
              },
              
              backgroundColor: Colors.blueGrey[400],
            ))
              );
    }

  void _addfood() {
print(widget.foodinfo.foodid);
print(widget.userinfo.email);

 http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/add_cart.php"),
        body: {
          "foodid": widget.foodinfo.foodid,
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

  }

              