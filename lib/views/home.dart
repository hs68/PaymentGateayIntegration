import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;
  String amount;
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerpaymentsuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerpaymenterror);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerexternalwallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var option = {
      "key": "rzp_test_Bp6mY0KcmDXpEp",
      "amount": num.parse(amount) * 100,
      "description": "for purchase",
      "prefill": {
        "email": "harsh@gmail.com",
        "contact": "11111111111",
      },
      "external": {
        "wallets": ["Paytm"],
      },
    };
    try {
      razorpay.open(option);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerpaymentsuccess() {
    print("Payment Successful");
    Fluttertoast.showToast(msg: "Payment Success");
  }

  void handlerpaymenterror() {
    print("Payment Error");
    Fluttertoast.showToast(msg: "Payment Failure");
  }

  void handlerexternalwallet() {
    print("Payment external wallet");
    Fluttertoast.showToast(msg: "Payment extrenal wallet error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Razorpay",
        ),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              amount = value;
            },
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "Enter the amount",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              openCheckOut();
            },
            child: Text(
              "Pay",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
