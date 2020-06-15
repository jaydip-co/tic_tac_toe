
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Elements/OneElement.dart';
import 'package:tictactoe/Models/UserModel.dart';
import 'package:tictactoe/Providers/TurnProvider.dart';
import 'package:tictactoe/Services/DatabaseServece.dart';
class box extends StatelessWidget {
  final int index;
  final int value;
  final bool turn;
  final String point;

  const box({Key key, this.index,  this.value, this.turn, this.point}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final host = Provider.of<turnProvider>(context,listen: false).ishost;
    final docId = Provider.of<turnProvider>(context,listen: false).getId;
    print('builded....$index ');

    return  GestureDetector(


        onTap: (turn && value==4 ) ?  () async {

          await databaseService().setValue(docId, index, 20, host);


        }  : (){print('hahahah');},
        child: Container(
          margin: EdgeInsets.all(1.0),
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: (turn && value==4 ) ? Colors.grey[100] : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(9)),
            border: Border.all(color: Colors.red),

          ),
          child: OneElement(value: value,),

          ),

        );
  }
}
