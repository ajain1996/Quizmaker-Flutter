import 'package:Quiz/views/home.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
  });

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(
                  fontSize: 26.0,
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  "You answered ${widget.correct} answers correctly and ${widget.incorrect} answered incorrectly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: blueButton(
                  context: context,
                  label: 'Go to Home',
                  buttonWidth: MediaQuery.of(context).size.width / 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
