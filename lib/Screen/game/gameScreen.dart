
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Screen/game/Wining.dart';
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
        body:StreamBuilder<int>(
          initialData: 0,
          stream: database.Win,
          builder: (con,data){
            print(data.data);

            switch(data.data){
              case 0:
                return playBox();
              case 1:
                return WiningScreen();
              default:
                return Text('error');
            }
          },
        ),
        );
  }
}

