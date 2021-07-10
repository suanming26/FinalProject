import 'package:bamboogrove/foodinfo.dart';
import 'package:bamboogrove/myproduct.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Updateproduct extends StatefulWidget {
  final Foodinfo foodinfo;

  const Updateproduct({Key key, this.foodinfo}) : super(key: key);

  @override
  _UpdateproductState createState() => _UpdateproductState();
}

class _UpdateproductState extends State<Updateproduct> {
   double screenHeight, screenWidth;
    int _category = 0;

  TextEditingController nameC = new TextEditingController();
  TextEditingController priceC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

      
                return Scaffold(
                  appBar: AppBar(
                      title: Text('Product Editor'),
                      backgroundColor: Colors.cyan.shade700,
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
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
                              decoration: BoxDecoration(color: Colors.cyan.shade200),
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
                              trailing: IconButton(
                                icon: Icon(Icons.delete,
                              size:35),
                              onPressed: (){
                                Navigator.of(context).pop();
                                _delete(widget.foodinfo.foodid);
                                Navigator.pushReplacement(context,
                                   MaterialPageRoute(builder: (context) => Myproduct(foodinfo:widget.foodinfo)));
                              }
                              )),
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
                              fontWeight: FontWeight.bold)),
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
                      
                ],),
              ),
              floatingActionButton:FloatingActionButton(
                 backgroundColor: Colors.blueGrey[400],
              
              onPressed: () {
               _updateFood(context);
               },
                child:Icon(Icons.edit,
                color: Colors.white,
                size:25),

              ));
    }
               
    Future<void> _updateFood(BuildContext context) async {
     
      if(widget.foodinfo.foodcat == "Western Food"){
        _category = 1;
      }else if(widget.foodinfo.foodcat == "Noodles"){
        _category = 2;
      }else if(widget.foodinfo.foodcat == "Rice"){
        _category = 3;
      }  

      return await showDialog(
              context: context,
             builder: (BuildContext context){
               return SingleChildScrollView(
                  child: AlertDialog(
                   title:Text("Update Your Food",
                   style:TextStyle(
                     fontSize:20,
                     color:Colors.cyan[900],
                     fontStyle:FontStyle.italic),),
                   content: new Container(
                     height:308,
                     child: Column(
                       children: [ 
                        ListTile( 
                              title:TextField(
                                controller:nameC,
                                keyboardType: TextInputType.name,
                                 decoration: InputDecoration(
                                 labelText: 'Food Name',
                                 labelStyle:
                                    TextStyle(fontSize: 20, color: Colors.black),
                                 )
                            ),),
                      ListTile( 
                              title:TextField(
                                controller:priceC,
                                keyboardType: TextInputType.number,
                                 decoration: InputDecoration(
                                 labelText: 'Food Price',
                                 labelStyle:
                                    TextStyle(fontSize: 20, color: Colors.black),
                                 )
                            ),),
                         ListTile( 
                              title:Text("Western Food",
                                style:TextStyle(fontSize:20)),
                               trailing:Radio(
                                 activeColor:Colors.blueGrey,
                                 value: 1,
                                 groupValue: _category,
                                 onChanged:(value){
                                   setState(() {
                                     _category = value;
                                   });
                                 }
                               ),
                                ),
                           ListTile( 
                              title:Text("Noodles",
                                style:TextStyle(fontSize:20)),
                               trailing:Radio(
                                 activeColor:Colors.blueGrey,
                                 value: 2,
                                 groupValue: _category,
                                 onChanged:(value){
                                   setState(() {
                                     _category = value;
                                   });
                                 }
                               ),
                                ),
                             ListTile( 
                              title:Text("Rice",
                                style:TextStyle(fontSize:20)),
                               trailing:Radio(
                                 activeColor:Colors.blueGrey,
                                 value: 3,
                                 groupValue: _category,
                                 onChanged:(value){
                                   setState(() {
                                     _category = value;
                                   });
                                 }
                               ),
                                ),
                     ],),
                     ),
                   actions: [
                     TextButton(
                       style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.blueGrey[400]),
                       child:Text("Submit"),
                       onPressed: (){
                       _update(_category);
                         Navigator.of(context).pop();
                     }),
                     TextButton(
                       style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red[200]),
                       child:Text("Cancel"),onPressed: (){
                       Navigator.of(context).pop();
                     })
                   ],  
                 ),
               );
      });}

  void _update(int _cat) {
    String _name = nameC.text.toString();
    String _price = priceC.text.toString();
    String _category1 = " ";

    if(_cat == 1){
      _category1 = "Western Food";
    }else if(_cat == 2){
      _category1 = "Noodles";
    }else if(_cat == 3){
      _category1 = "Rice";
    }
    _name = (nameC.text.toString() == "")
        ? widget.foodinfo.foodname
        : nameC.text.toString();

    _price = (priceC.text.toString() == "")
    ? widget.foodinfo.foodprice
    : priceC.text.toString();

    print(_name);
    print(_price);
    print(_category1);

    http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/updateproduct.php"),
        body: {
          "foodid":widget.foodinfo.foodid,
          "foodname": _name,
          "foodprice": _price,
          "foodcat": _category1,

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
        setState(() {
          widget.foodinfo.foodname = _name;
          widget.foodinfo.foodprice = _price;
          widget.foodinfo.foodcat = _category1;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
    print(_name);
    print(_price);
    print(_category1);
      }

    });
    return;

  }

  void _delete(String foodid) {
    
    print(foodid);

 http.post(
        Uri.parse("https://javathree99.com/s271490/bamboogrove/php/deleteproduct.php"),
        body: {
          "foodid":widget.foodinfo.foodid,

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