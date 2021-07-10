import 'package:bamboogrove/foodinfo.dart';
import 'package:bamboogrove/searchscreen.dart';
import 'package:bamboogrove/updateproduct.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:bamboogrove/addproduct.dart';

class Myproduct extends StatefulWidget {
    final Foodinfo foodinfo;

    const Myproduct({Key key, this.foodinfo}) : super(key: key);
  @override
  _MyproductState createState() => _MyproductState();
}

class _MyproductState extends State<Myproduct> {
  double screenHeight, screenWidth;
  List _productList;
  String _titlecenter = "Loading....";
  TextEditingController searchc = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadingProduct();
  }

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('My Product'),
          backgroundColor: Colors.cyan.shade700,
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
        body: Container(
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
                                    _updateProduct(index);
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
        floatingActionButton: Visibility(
            visible: _visible,
            child: FloatingActionButton.extended(
              label: Text(
                'Add',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              icon: Icon(Icons.add),
              backgroundColor: Colors.blueGrey[400],
            )));
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

  void _updateProduct(int index) {
    Foodinfo foodinfo = new Foodinfo(
      foodid: _productList[index]['foodid'],
      foodcat: _productList[index]['foodcat'],
      foodname: _productList[index]['foodname'],
      foodprice: _productList[index]['foodprice']
    );
    Navigator.push(context,
      MaterialPageRoute(builder: 
      (context) => Updateproduct(foodinfo:foodinfo)));
  }
}
