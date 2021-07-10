import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
//  final Foodinfo food;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchc = new TextEditingController();
  String _titlecenter = "";
  List _searchList;
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan.shade700,
        title: Container(
            height: 40,
            child: TextField(
              controller: searchc,
              style: TextStyle(fontSize: 18),
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  filled: true,
                  hintText: "Search.."),
            )),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchItem();
                  }))
        ],
      ),
      body: Container(
          child: Column(children: [
        _searchList == null
            ? Flexible(child: Center(child: Text(_titlecenter)))
            : Flexible(
                child: Center(
                    child: Container(
                        child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (screenWidth / screenHeight) / 0.9,
                children: List.generate(_searchList.length, (index) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://javathree99.com/s271490/bamboogrove/images/product/${_searchList[index]['foodid']}.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: Text(_searchList[index]['foodname'],
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
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Text(
                                "RM " + _searchList[index]['foodprice'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ]),
                        ]),
                      ),
                    ),
                  );
                }),
              )))),
      ])),
    );
  }

  void _searchItem() {
    String searchItem = searchc.text.toString();
    print(searchItem);
    http.post(
        Uri.parse(
            "https://javathree99.com/s271490/bamboogrove/php/loadproduct.php"),
        body: {"foodname": searchItem}).then((response) {
      if (response.body == "nodata") {
        _searchList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _searchList = jsondata["products"];
        print(_searchList);
        setState(() {});
      }
    });
  }
}
