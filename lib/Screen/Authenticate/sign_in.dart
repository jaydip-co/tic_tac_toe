import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Services/AuthService.dart';


class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//  final AuthService _auth = AuthService();
  String email ='';
  String password ='';
  String error ='';
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.blueGrey[200],

        appBar: AppBar(
          backgroundColor: Colors.blueGrey[400],
          title: Text('sign in with Email and password',),
          actions: <Widget>[
            RaisedButton(
              child: Text('signOut'),
              onPressed: () async {
                Authservice().Signout();

              },

            )
          ],

        ),
        resizeToAvoidBottomPadding: true,
        body: Container(
          padding: EdgeInsets.fromLTRB(50.0, 130.0, 50.0, 0),
          child: Form(
            key: _formkey,
            child:  RaisedButton(
              color: Colors.red[100],
              child: Text('Sign in',
                style: TextStyle(fontSize: 20.0),),
              onPressed: () async {
                FirebaseUser user = await Authservice().SignInAno();
                //print(user.uid);

              },
            ),
            ),
          ),
        );
  }
}