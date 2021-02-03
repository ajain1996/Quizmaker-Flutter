import 'package:Quiz/services/database.dart';
import 'package:Quiz/views/home.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion({this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String question, option1, option2, option3, option4;

  DataBaseService dataBaseService = new DataBaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      await dataBaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Center(child: appBar(context)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black87)),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter Question" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter option1" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "option1 {Correct option}",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter option2" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "option2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter option3" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "option3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter option4" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "option4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: blueButton(
                            context: context,
                            label: "Submit",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                          },
                          child: blueButton(
                            context: context,
                            label: "Add Question",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 24,
                          ),
                        ),
                        SizedBox(height: 38.0),
                      ],
                    ),
                    SizedBox(height: 36.0),
                  ],
                ),
              ),
            ),
    );
  }
}
