
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Screen/Loading.dart';
import 'file:///E:/projects/flutter/tic_tac_toe/lib/Screen/game/PlayBox.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';


class gameScreen extends StatefulWidget {
  @override
  _gameScreenState createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {
  bool isLoading = false;
  exmpleDatabase data;
  StartListeningForCancel(exmpleDatabase database){
    database.CancelStream.listen((event) {
      if(event == 1){
        Navigator.pop(context);
        database.DeleteFile();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<exmpleDatabase>(context);
    data = database;
    database.startListening();
    ModalRoute.of(context).addScopedWillPopCallback(()async{
      bool result = false;
     await showConformDialog(context).then((value) async {
        if(value == 'ok'){
          setState(() {
            isLoading = true;
          });
          await database.setCancel();
          await database.DeleteFile();
          result = true;
        }
      });
      return result;
    });
    return  isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'game is on',
          style: TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () async {
              await showConformDialog(context).then((value) async {
                if(value == "ok"){
                  setState(() {
                    isLoading = true;
                  });
                  await database.setCancel();
                  StartListeningForCancel(database);
                }
              });
            },
          ),
        ],
      ),
      body:StreamBuilder<int>(
        initialData: 0,
        stream: database.Win,
        builder: (con,data){
          switch(data.data){
            case 0:
              return playBox();
            case 1:
              myCallback((){
                Navigator.popAndPushNamed(context, '/result');
              });
              return Container();
            default:
              return Text('error');
          }
        },
      ),
    );
  }
  void myCallback(Function callback){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }

  Future<String> showConformDialog(BuildContext context){
    return showDialog(
      barrierDismissible: true,
        context: context,
      child: AlertDialog(
        content: Text('press ok to exit'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              Navigator.of(context).pop("ok");
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: (){
              Navigator.of(context).pop("cancel");
            },
          ),
        ],
      ),
    );
  }
}

