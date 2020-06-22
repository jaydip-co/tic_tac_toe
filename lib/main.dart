

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Screen/game/Wining.dart';
import 'package:tictactoe/Screen/game/gameScreen.dart';
import 'package:tictactoe/Services/AuthService.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';
import 'package:tictactoe/testDatabase.dart';
import 'package:tictactoe/testScreen.dart';


import 'Models/UserModel.dart';
import 'Wrapper.dart';

void main() {
  runApp(Provider<testdata>(
      create: (con) => testdata(),
      child: MyApp()
  )
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: Authservice().user,
        ),
        Provider<exmpleDatabase>(
          create: (con) => exmpleDatabase(),
        ),

      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/result': (con) => completed(),
          '/gameScreen': (con) => gameScreen(),
        },
      )
    );
  }
}
