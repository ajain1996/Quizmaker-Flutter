import 'package:Quiz/services/auth.dart';
import 'package:Quiz/views/create_quiz.dart';
import 'package:Quiz/views/play_quiz.dart';
import 'package:Quiz/views/signin.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;

  final User _user = FirebaseAuth.instance.currentUser;

  AuthService authService = new AuthService();

  final CollectionReference _quizRef =
      FirebaseFirestore.instance.collection('Quiz');

  logout() async {
    await authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _quizRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // display data in listvie
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return QuizTitle(
                      title: document.data()['quizTitle'],
                      imgUrl: document.data()['quizImgurl'],
                      desc: document.data()['quizDesc'],
                      quizId: document.data()['quizId'],
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: appBar(context)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              logout();
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.logout,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuiz()),
          );
        },
      ),
    );
  }
}

class QuizTitle extends StatelessWidget {
  final String imgUrl, title, desc, quizId;
  QuizTitle({
    @required this.desc,
    @required this.imgUrl,
    @required this.title,
    @required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizId)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        height: 178.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                height: 178,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
