import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' show pow;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Armstrong Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String armText = "";
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isloading = false;
  TextEditingController numController = new TextEditingController();

  onSubmit() {
    setState(() {
      isloading = true;
    });
    print(isArmstrongNumber(int.tryParse(numController.text)));
    isArmstrongNumber(int.tryParse(widget.armText));
    setState(() {
      isloading = false;
    });
  }

  String isArmstrongNumber(final int input) {
    final String numberAsString = input.toString();
    final int numOfDigits = numberAsString.length;
    num sum = 0;
    String retStr = "";
    for (int count = 0; count < numOfDigits; count++) {
      final String digitAsString = numberAsString.substring(count, count + 1);
      final int digit = int.parse(digitAsString);
      sum += pow(digit, numOfDigits);
    }
    if (input == sum) {
      retStr = "$input is an Armstrong Number";
    } else {
      retStr = "$input is not an Armstrong Number";
    }
    return retStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isloading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    // controller: numController,
                    onChanged: (val) {
                      widget.armText = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'PLEASE ENTER A NUMBER',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onSubmit();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Result',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    "${isArmstrongNumber(int.tryParse(widget.armText))}" != null
                        ? "${isArmstrongNumber(int.tryParse(widget.armText))}"
                        : "",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
    );
  }
}
