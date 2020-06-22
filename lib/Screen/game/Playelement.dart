
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';
class box extends StatelessWidget {
  final int value;
  final bool turn;
  final int index;

  const box({Key key, this.value,this.turn,this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {

//    final exampledata = Provider.of<exmpleDatabase>(context,listen: false);
   // print('builded....$index ');
    final database = Provider.of<exmpleDatabase>(context,listen: false);
    final val = witchValue(value);
    return  GestureDetector(


        onTap: (turn && value == 0)  ?  () async {

//          await exampledata.setValueAndTurn(index);
            database.setValueAndTurn(index);

        }  : (){},
        child: Container(
          margin: EdgeInsets.all(1.0),
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: (turn && value==0 ) ? Colors.grey[100] : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(9)),
            border: Border.all(color: Colors.red),

          ),
          child: Center(
            child: Text(val,
              style: TextStyle(fontSize: 70),),
          ),

          ),

        );
  }

  String witchValue(int val){
    switch(val){
      case 0:
        return '';
        break;
      case 1:
        return 'X';
      case 2:
        return 'O';
    }
  }
}
