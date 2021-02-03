import 'package:Quiz/helper/functions.dart';
import 'package:Quiz/services/auth.dart';
import 'package:Quiz/views/home.dart';
import 'package:Quiz/views/signup.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn() async {
    // await Firebase.initializeApp();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signInEmailPassword(email, password).then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: appBar(context)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    // Spacer(),
                    SizedBox(height: 300),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty
                            ? "This field can\'t be empty"
                            : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 6.0),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? "Please enter password" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 24.0),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: blueButton(context: context, label: "Sign In"),
                    ),
                    SizedBox(height: 18.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont\'t have an account? ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
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
