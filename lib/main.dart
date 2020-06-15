
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Providers/TurnProvider.dart';
import 'package:tictactoe/Screen/Authenticate/sign_in.dart';
import 'package:tictactoe/Screen/Invitation/invitation.dart';
import 'package:tictactoe/Screen/game/gameScreen.dart';
import 'package:tictactoe/Services/AuthService.dart';
import 'package:tictactoe/ennum/ennums.dart';

import 'Models/UserModel.dart';
import 'Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authservice().user,
      child: ChangeNotifierProvider(
        create: (con) => turnProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/' : (context) => Wrapper(),
            '/invitation' : (context) => invitation(),
            '/gameScreen' :(context) => Consumer<turnProvider>(
              builder: (con,data,_) {
                final ishost = data.ishost;
                if(data.ishost != null) {
                  print("iiiiiiiii$ishost");
                  return gameScreen(
                    player: ishost ? Players.Host : Players.Guest,);
                }
                else{
                  return Center(
                    child: Text('Loading'),
                  );
                }
                },
            ),
          },
        ),
      ),
    );
  }
}
