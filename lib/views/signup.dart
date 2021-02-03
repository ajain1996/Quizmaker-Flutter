import 'package:Quiz/helper/functions.dart';
import 'package:Quiz/services/auth.dart';
import 'package:Quiz/views/home.dart';
import 'package:Quiz/views/signin.dart';
import 'package:Quiz/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email, password, name;
  bool _isLoading = false;
  AuthService authService = new AuthService();

  signUp() async {
    // await Firebase.initializeApp();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signUpEmailPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });

          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: [
                  SizedBox(height: 250),
                  // Spacer(),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Name field can\'t be empty" : null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                  SizedBox(height: 6.0),
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Email field can\'t be empty" : null;
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
                      signUp();
                    },
                    child: blueButton(context: context, label: "Sign Up"),
                  ),
                  SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
    );
  }
}
