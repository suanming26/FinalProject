import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bamboogrove/myproduct.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/photo.png';
  File _image;
  int _radioValue =0;

  TextEditingController nameC = new TextEditingController();
  TextEditingController priceC = new TextEditingController();
  TextEditingController categoryC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            title: Text('ADD PRODUCT'),
            backgroundColor:Colors.cyan.shade700,
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  //SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => {
                      _onPicture(),
                    },
                    child: Container(
                        height: screenHeight / 2.5,
                        width: screenWidth / 1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? AssetImage(pathAsset)
                                : FileImage(_image),
                            fit: BoxFit.scaleDown,
                          ),
                        )),
                  ),
                  Card(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      elevation: 0,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            TextField(
                                controller: nameC,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[200], width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo[800], width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Food Name',
                                  labelStyle:
                                      TextStyle(fontSize: 20, color: Colors.black),
                                )),
                            SizedBox(height: 5),
                            TextField(
                                controller: priceC,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[200], width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo[800], width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Food Price',
                                  labelStyle:
                                      TextStyle(fontSize: 20, color: Colors.black),
                                )),
                            new Row(
                          children: <Widget>[
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                           onChanged: (value){
                            setState(() {
                              _radioValue = value;
                            });
                          },
                        ),
                        new Text(
                          'Western Food',
                          style: 
                          new TextStyle(
                            fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                        ),
                        new Radio(
                          value: 2,
                          groupValue: _radioValue,
                           onChanged: (value){
                            setState(() {
                              _radioValue = value;
                            });
                          },
                        ),
                        new Text(
                          'Noodles',
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                           ] ),
                        new Row(
                          children: <Widget>[
                            new Radio(
                          value: 3,
                          groupValue: _radioValue,
                          onChanged: (value){
                            setState(() {
                              _radioValue = value;
                            });
                          },
                        ),
                        new Text(
                          'Rice',
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                          ]),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minWidth: screenWidth / 2.5,
                          height: 40,
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 20, 
                            color: Colors.white, ),
                          ),
                          onPressed: (){
                            _addProduct(_radioValue);
                          },
                          color: Colors.blueGrey[400],
                        ),
                      ],
                    ),
                  ))
                  ])
          ),
        ),
      ),
    );
  }

  _onPicture() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.fromSize(
                          size: Size(100, 100),
                          child: Material(
                              color: Colors.blueGrey,
                              elevation: 10,
                              child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () =>
                                      {Navigator.pop(context), _chooseCamera()},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.camera),
                                      Text('Camera',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                    ],
                                  )))),
                      SizedBox(width: 10),
                      SizedBox.fromSize(
                          size: Size(100, 100),
                          child: Material(
                              color: Colors.blueGrey,
                              elevation: 10,
                              child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () => {
                                        Navigator.pop(context),
                                        _chooseGallery()
                                      },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.folder),
                                      Text('Gallery',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                    ],
                                  )))),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  void _addProduct(int _radioValue) {
    String _name = nameC.text.toString();
    String _price = priceC.text.toString();
    String _category ;

    if(_radioValue == 1){
      _category = "Western Food";
    }else if(_radioValue == 2){
      _category = "Noodles";
    }else {
      _category = "Rice";
    }
    
   // print(_category);

    if (_name.isEmpty &&  _price.isEmpty && _category.isEmpty) {
      Fluttertoast.showToast(
          msg: "Food Name/Price/Category is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_name.isEmpty) {
      Fluttertoast.showToast(
          msg: "Food Name is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_price.isEmpty) {
      Fluttertoast.showToast(
          msg: "Food Price is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_category.isEmpty) {
      Fluttertoast.showToast(
          msg: "Food Category is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Text("Add New Food?"),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _newProduct(_name, _price, _category);
                    }),
                TextButton(
                    child: Text("CANCEL"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  void _newProduct(String foodname, String foodprice, String foodcat) {
    String base64Image = base64Encode(_image.readAsBytesSync());

    print(base64Image);
    print(foodname);
    print(foodprice);
    print(foodcat);
    http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/addproduct.php"),
        body: {
          "foodname": foodname,
          "foodprice": foodprice,
          "foodcat": foodcat,
          "encoded_string": base64Image,
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Myproduct()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
            print(base64Image);
    print(foodname);
    print(foodprice);
    print(foodcat);
      }

    });
    return;
  }

}
