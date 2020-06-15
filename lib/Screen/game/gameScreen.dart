import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Models/UserModel.dart';
import 'package:tictactoe/Providers/TurnProvider.dart';
import 'package:tictactoe/Screen/Home/PlayBox.dart';
import 'package:tictactoe/Services/DatabaseServece.dart';
import 'package:tictactoe/ennum/ennums.dart';

class gameScreen extends StatelessWidget {
  final Players player;
  gameScreen({this.player,});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context,listen: false);
    final id = Provider.of<turnProvider>(context,listen: false).getId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'game is on',
          style: TextStyle(fontSize: 30),
        ),

      ),
      body: MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot>.value(value: databaseService(uid: id).signleValue),
//        Provider(
//          create:(context) => databaseService(),
//        ),
        ],
        child: playBox(player: player,),
      ),
    );
  }
}
