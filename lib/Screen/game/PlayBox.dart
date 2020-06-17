

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///E:/projects/flutter/tic_tac_toe/lib/Screen/game/Playelement.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';


class playBox extends StatelessWidget {
  playBox({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

  final database = Provider.of<exmpleDatabase>(context,listen: false);

    return StreamBuilder<List<int>>(
      stream: database.getValues,
      initialData: [1,1,1,1,1,1,1,1,1,0],
      builder: (con,data){
        print("get....${data.data}");
        final values = data.data ?? [1,1,1,1,1,1,1,1,1,0];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            reverser(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  'player 1',
                  style: TextStyle(
                    fontSize: 20,
                    color: (values[9] == 1) ? Colors.red : Colors.grey,

                  ),
                ),
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                box(value: values[0] ,turn: values[9]==1,index: 1),

                box(value: values[1] ,turn: values[9]==1,index: 2),
                box(value: values[2] ,turn: values[9]==1,index: 3),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                box(value: values[3] ,turn: values[9]==1,index: 4),

                box(value: values[4] ,turn: values[9]==1,index: 5),
                box(value: values[5] ,turn: values[9]==1, index: 6),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                box(value: values[6] ,turn: values[9]==1,index: 7),

                box(value: values[7] ,turn: values[9]==1,index: 8),
                box(value: values[8] ,turn: values[9]==1,index: 9),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only( top : 20),
              child: Center(
                child: Text(
                  'player 2',
                  style: TextStyle(
                    fontSize: 20,
                    color: values[9] == 1? Colors.grey : Colors.red,

                  ),
                ),
              ),
            ),



          ],
        );
      },
    );
  }
}
