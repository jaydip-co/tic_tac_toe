 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class completed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<exmpleDatabase>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('result'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay) ,
            onPressed: (){
              data.DeleteFile();
              Navigator.of(context).popAndPushNamed('/');
            },
            tooltip: "replay",
          ),
        ],
      ),
      body: Center(
          child: FutureBuilder<int>(
            future: data.getResult,
            builder: (cont,data){
              Widget chield = Text('loading');
              switch(data.data){
                case 0:
                  chield = Text('loose');
                  break;
                case 1:
                  chield = Text('win');
                  break;
                case 3:
                  chield = Text('draw');
                  break;
                default:
                  chield = SpinKitWanderingCubes(size: 20.0,color: Colors.cyan,);
              }
              return chield;
            },
          )
      ),
    );
  }
}

