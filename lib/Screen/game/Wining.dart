 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';

class completed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<exmpleDatabase>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('result'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay) ,
            onPressed: (){
              print('replay pressed');
            },
            tooltip: "replay",
          ),
        ],
      ),
      body: Center(
          child: FutureBuilder<int>(
            future: data.getResult,
            builder: (cont,data){
              print('value in widget... ${data.data}');
              Widget chield = Text('loading');
              switch(data.data){
                case 0:
                  chield = Text('loose');
                  break;
                case 1:
                  chield = Text('win');
              }
              return chield;
            },
          )
      ),
    );
  }
}

