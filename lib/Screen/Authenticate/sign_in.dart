import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Services/AuthService.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email ='';
  String password ='';
  String error ='';
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('sign in Anonymously',),
      ),
        resizeToAvoidBottomPadding: true,
        body: Center(
          child: Form(
            key: _formkey,
            child:  RaisedButton(
              child: Text('Sign in',
                style: TextStyle(fontSize: 20.0),),
              onPressed: () async {
                FirebaseUser user = await Authservice().SignInAno();
              },
            ),
            ),
        ),
        );
  }
}