

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Screen/Loading.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';
import 'dart:math';
class invitation extends StatefulWidget {
  @override
  _invitationState createState() => _invitationState();
}

class _invitationState extends State<invitation> {

  String status = '';
  bool isLoading =false;
  StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    Provider.of<exmpleDatabase>(context,listen: false).close();
  }

  mycallback(Function callback){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }

  startListening(exmpleDatabase database){
    _subscription = database.WaitingForDone.listen((event) {
      if(event == 1){
        Navigator.of(context).popAndPushNamed('/gameScreen');
      }
    });
  }


   Future showdialogForCreate(BuildContext context,String id)  async {

    String value ;
    return showDialog(
        context: context,
      builder: (context) {
          final dataservice = Provider.of<exmpleDatabase>(context,listen: false);
          return AlertDialog(
            title: Text('decide'),
            content: Form(
              child: TextFormField(
                initialValue: '$id',
                onChanged: (val) => value = val,

              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: (){
                  Navigator.pop(context,id);
                },
                child: Text('ok'),
              ),

              RaisedButton(
                child: Text('cancel'),
                onPressed: () {
                  dataservice.DeleteFile();
                  Navigator.pop(context);
                },
              )
            ],
          );
      }

    );

  }

  Future<String> showDialogForJoin(BuildContext context){
    String id;
    return  showDialog(context: context,
     builder: (context) {
       return AlertDialog(
         title: Text('Enter Code'),
         content: Form(
           child: TextFormField(
             onChanged:(val) => id=val,
           ),
         ),
         actions: <Widget>[
           RaisedButton(
             child: Text('ok'),
             onPressed: () async{
               if(id != null) {
                 Navigator.of(context).pop(id);
               }
             },
           ),
           RaisedButton(
             child: Text('cancle'),
             onPressed: (){
               Navigator.pop(context);
             },
           )

         ],
       );
     }
     );
  }
  @override
  Widget build(BuildContext context) {
    int id;
    final database = Provider.of<exmpleDatabase>(context,listen: false);
    Random random = Random.secure();
    return isLoading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text('invitation screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton (
                  child: Text('Create'),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    while(id == null){
                      id = random.nextInt(999999);
                      if(id < 999){
                        id = null;
                        continue;
                      }
                      if(await database.isDocumentAvailable('$id')){
                        id = null;
                        continue;
                      }
                    }
                    await database.CreateNewGame('$id');
                    setState(() {
                      isLoading = false;
                    });
                    database.setGameId('$id');
                    database.setIsCreated();

                    await showdialogForCreate(context, '$id').then((data){
                      setState(() {
                        status = 'id is...$data';
                      });
                      database.StartListeningForWin();
                      startListening(database);
                    });
                  }
              ),
              RaisedButton(
                  child: Text('Join'),
                  onPressed: () async {
                    showDialogForJoin(context).then((value)  async {
                      if(value.length > 1){
                        setState(() {
                          isLoading = true;
                        });
                        if(await database.isDocumentAvailable(value)){
                          database.setGameId(value);
                          database.StartListeningForWin();
                          startListening(database);
                          await database.setDone();
                        }
                        else{
                          setState(() {
                            isLoading = false;
                            status ="Wrong code";
                          });

                        }
                      }
                    });
                  }
              ),
              Text("$status",style: TextStyle(color: Colors.red,fontSize: 16.0),),
            ],
          ),
        )
    );
  }
}

