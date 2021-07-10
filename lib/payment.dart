
import 'dart:convert';
import 'package:bamboogrove/bill.dart';
import 'package:bamboogrove/delivery.dart';
import 'package:bamboogrove/foodpayment.dart';
import 'package:bamboogrove/mappage.dart';
import 'package:date_format/date_format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class Payment extends StatefulWidget {
//   final Foodinfo foodinfo;
   final Userinfo userinfo;
   final Foodpayment foodpayment;

  const Payment({Key key, this.userinfo, this.foodpayment}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
   double screenHeight, screenWidth;
  String _titlecenter = "Loading your cart";
  List _cartList = [];
  double _totalprice ;
    bool _statusdel = false;
  bool _statuspickup = true;
  String address = "";
  int _radioValue = 0;
   String _delivery = "Pickup";
   TextEditingController locationC = new TextEditingController();
    String _setTime, _setDate, _selectedDate = "Date", _selectedTime = "Time";
  String _hour, _minute, _time, dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String location ;


 @override
  void initState() {
    super.initState();
      _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
        
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
     

    return Scaffold(
        appBar: AppBar(
          title: Text("PAYMENT"),
          backgroundColor:Colors.cyan.shade700,
          ),
          bottomNavigationBar: Material(
            child:Row(
              children: [
                Expanded(
                  child: Text("Total: RM " + _totalprice.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                   style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                ),
                Expanded(
                  child: 
                MaterialButton(
                  color:Colors.blueGrey.shade700,
                  onPressed: () {
                    _payment();
                  },
                  child: Text("Pay",
                  style:TextStyle(
                    fontSize: 16, color:Colors.white))
                  ),),
            ],)),
          body:SingleChildScrollView(
            child:Column(
              children: [
                Container( 
              height: screenHeight/ 2.5,
              width: screenWidth,
              child:Column(
                children: [
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
                          child: Container(
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
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              
                            ],
                          ))));
                    }));
              })),
              
              ],)
            ),
             Container(
                  margin: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Container(
                          width:420,
                          color: Colors.blueGrey[700],
                          alignment: Alignment.center,
                           child: Text(
                            "DELIVERY METHOD",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pickup",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:16)
                              ),
                            new Radio(
                              activeColor: Colors.blueGrey[400],
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                            Text("Delivery",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:16)),
                            new Radio(
                              activeColor: Colors.blueGrey[400],
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
               Visibility(
                  visible: _statuspickup,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            "PICKUP TIME",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _statusdel,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            "DELIVERY ADDRESS + DELIVERY TIME",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                    flex: 6,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: locationC,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Search/Enter address'),
                                            keyboardType: TextInputType.multiline,
                                            minLines:
                                                6, //Normal textInputField will be displayed
                                            maxLines:
                                                6, // when user presses enter it will adapt to it
                                          ),
                                        ],
                                      ),
                                    )),
                              Container(
                                  height: 120,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          
                                          onPressed: () =>
                                              {_getUserCurrentLoc()},
                                          child: Text("Location"),
                                          style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[400]
                                        ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        height: 2,
                                      ),
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Delivery _del =
                                                await Navigator.of(context)
                                                    .push(
                                              MaterialPageRoute(
                                                builder: (context) => MapPage(),
                                              ),
                                            );
                                            print(address);
                                            setState(() {
                                              locationC.text = _del.address;
                                            });
                                          },
                                          child: Text("Map"),
                                          style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[400]
                                        ),
                                        ),
                                      ),
                                       Divider(
                                        color: Colors.grey,
                                        height: 2,
                                      ),
                                      Container(
                                        width: 150,
                                        child: ElevatedButton(
                                          onPressed: () {
                                           locationC.clear();
                                          },
                                          child: Text("Clear"),
                                          style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[400]
                                        ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Date: ",style: TextStyle(fontSize: 16),),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: screenHeight/24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                onSaved: (String val) {
                                  _setDate = val;
                                },
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.only(bottom: 15.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Time: ",style: TextStyle(fontSize: 16),),
                          InkWell(
                            onTap: () {
                              print(_timeController.text.toString());
                              _selectTime(context);
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: screenHeight/24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                onSaved: (String val) {
                                  _setTime = val;
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _timeController,
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.only(bottom: 15.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ],
            )
          )
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
 _getUserCurrentLoc() async {
    
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
 
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

void _getPlace(Position pos) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    locationC.text = address;
  }

void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _delivery = "Pickup";
          _statusdel = false;
          _statuspickup = true;
          break;
        case 1:
          _delivery = "Delivery";
          _statusdel = true;
          _statuspickup = false;
          break;
      }
      print(_delivery);
    });
  }
Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }
  
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  void _payment() {
    locationC.text.toString() == ""
    ? location = "------"
    : location = locationC.text.toString();

    print(location);
    // print(_dateController.text.toString() + "  " +_timeController.text.toString());
    // print(locationC.text.toString());
    // print(_totalprice.toStringAsFixed(2));
    Foodpayment foodpayment = new Foodpayment(
      dateTime: _dateController.text.toString() + _timeController.text.toString(),
      address: location,
      foodamount: _totalprice.toStringAsFixed(2),
      status: _delivery,
    );
     Navigator.pushReplacement(context,
      MaterialPageRoute(builder: 
      (context) => Billpayment(foodpayment:foodpayment,userinfo:widget.userinfo)));
    
  }
}