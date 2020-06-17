
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///E:/projects/flutter/tic_tac_toe/lib/Screen/game/PlayBox.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';


class gameScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final database = Provider.of<exmpleDatabase>(context);

    database.startListening();

//    print("size...${fire.gameid}");
    return  Scaffold(
        appBar: AppBar(
          title: Text(
              'game is on',
            style: TextStyle(fontSize: 30),
          ),

        ),
        body: playBox(),
        );
  }
}
