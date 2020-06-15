

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Elements/Playelement.dart';
import 'package:tictactoe/ennum/ennums.dart';


class playBox extends StatelessWidget {
final Players player ;
  playBox({Key key, this.player}) : super(key: key);

  bool value;
  String point;

  setValue(bool val){
  value = val;
  print(val);
  }

  bool getValue () =>  value;
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<DocumentSnapshot>(context,listen: true).data ?? {};
    switch(player){
      case Players.Guest :
        print(player);
        if(data['guest'] == 1){
          setValue(true);
          break;
        }
        else{
          setValue(false);

        }
        break;
      case Players.Host :
        print(' jjajjjja $player  ${data['host']}');
        if(data['host'] == 1){
          setValue(true);
          break;
        }
        else{
          setValue(false);

        }
        break;

    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: Text(
              'player 1',
              style: TextStyle(
                  fontSize: 20,
                color: value ? Colors.red : Colors.grey,

              ),
            ),
          ),
        ),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            box(index: 1,value: data['1'] ?? 0,turn: value,),

            box(index: 2,value: data['2'] ?? 0,turn: value,),
            box(index: 3,value: data['3'] ?? 0,turn: value,),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            box(index: 4,value: data['4'] ?? 0,turn: value,),

            box(index: 5,value: data['5'] ?? 0,turn: value,),
            box(index: 6,value: data['6'] ?? 0,turn: value,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            box(index: 7,value: data['7'] ?? 0,turn: value,),

            box(index: 8,value: data['8'] ?? 0,turn: value,),
            box(index: 9,value: data['9'] ?? 0,turn: value,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only( top : 20),
          child: Center(
            child: Text(
              'player 2',
              style: TextStyle(
                fontSize: 20,
                color: value ? Colors.grey : Colors.red,

              ),
            ),
          ),
        ),


      ],
    );
  }
}
