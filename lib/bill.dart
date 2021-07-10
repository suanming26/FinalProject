
import 'dart:async';
import 'package:bamboogrove/foodpayment.dart';
import 'package:bamboogrove/mainmenu.dart';
import 'package:bamboogrove/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Billpayment extends StatefulWidget {
final Userinfo userinfo;
final Foodpayment foodpayment;


  const Billpayment({Key key, this.userinfo, this.foodpayment}) : super(key: key);

  @override
  _BillpaymentState createState() => _BillpaymentState();
}

class _BillpaymentState extends State<Billpayment> {
   Completer<WebViewController> _controller = Completer<WebViewController>();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor:Colors.cyan.shade700,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pushReplacement(context,
      // MaterialPageRoute(builder: 
      // (context) => Mainscreen(userinfo:widget.userinfo)));
      //     }
      //   )
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: 
                WebView(
                  initialUrl:
                      'https://javathree99.com/s271490/bamboogrove/php/generate_bill.php?email=' +
                          widget.userinfo.email +
                          '&name=' +
                          widget.userinfo.username +
                          '&amount=' +
                          widget.foodpayment.foodamount+
                          '&address=' +
                          widget.foodpayment.address +
                          '&dateTime=' +
                          widget.foodpayment.dateTime +
                          '&status=' +
                          widget.foodpayment.status,

                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}