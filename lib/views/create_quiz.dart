import 'dart:io';

import 'package:Quiz/services/database.dart';
import 'package:Quiz/views/add_question.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  File _image;
  final selected = ImagePicker();

  String quizImageUrl, quizTitle, quizDescription, quizId;

  DataBaseService dataBaseService = new DataBaseService();

  Future getImage() async {
    final selectedImage = await selected.getImage(source: ImageSource.gallery);

    setState(() {
      if (selectedImage != null) {
        _image = File(selectedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_image != null) {
        // Uploading Images to Firestore
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('BlogImages')
            .child("${randomAlphaNumeric(9)}.jpg");

        final firebase_storage.UploadTask uploadTask = ref.putFile(_image);

        final link = await (await uploadTask).ref.getDownloadURL();
        print('This is url: ${link}');
        quizId = randomAlphaNumeric(16);
        Map<String, String> quizMap = {
          "quizId": quizId,
          "quizImgurl": link,
          "quizDesc": quizDescription,
          "quizTitle": quizTitle,
        };

        dataBaseService.addQuizData(quizMap, quizId).then((value) {
          setState(() {
            _isLoading = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestion(
                  quizId: quizId,
                ),
              ),
            );
          });
        });
      } else {}
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
                    // TextFormField(
                    //   validator: (val) {
                    //     return val.isEmpty ? "Please enter ImageUrl" : null;
                    //   },
                    //   decoration: InputDecoration(
                    //     hintText: "Quiz Image url",
                    //   ),
                    //   onChanged: (val) {
                    //     quizImageUrl = val;
                    //   },
                    // ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Please enter Quiz title" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty
                            ? "Please enter Quiz description"
                            : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Quiz description",
                      ),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),

                    SizedBox(height: 6.0),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: _image != null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200.0,
                              child: Image.file(_image),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 14.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: blueButton(context: context, label: "Create Quiz"),
                    ),
                    SizedBox(height: 36.0),
                  ],
                ),
              ),
            ),
    );
  }
}
