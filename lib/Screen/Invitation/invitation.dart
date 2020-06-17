

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Services/DatabaseServece.dart';
import 'package:tictactoe/Services/exampleDatabase.dart';
import 'dart:math';
class invitation extends StatefulWidget {
  @override
  _invitationState createState() => _invitationState();
}

class _invitationState extends State<invitation> {


   Future showdialogForCreate(BuildContext context,String id)  async {

    String value ;
    return showDialog(
        context: context,
      builder: (context) {
//          final dataservice = Provider.of<exmpleDatabase>(context,listen: false);
          return StreamBuilder<int>(
            stream: databaseService().waitFromCoonfermation(id),
            builder: (context,snapshot){
              print(snapshot.data);

              if(snapshot.data == 1){
                print(snapshot.data);
                Navigator.of(context).pop();
                return Container();
              }
              else {
                return AlertDialog(
                  title: Text('deside'),
                  content: Form(
                    child: TextFormField(
                      initialValue: '$id',
                      onChanged: (val) => value = val,

                    ),
                  ),
                  actions: <Widget>[

                    RaisedButton(
                      child: Text('cancle'),
                      onPressed: () {
                        databaseService().deleteDocument(id);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              }
              },
          );
      }

    );

  }

  Future<String> showDialogForJoin(BuildContext context){


     return  showDialog(context: context,
     builder: (context) {
       return dialogWidget();
     }
     );
  }
  @override
  Widget build(BuildContext context) {
//      final dataservice = Provider.of<exmpleDatabase>(context,listen: false);
    int id;
    final database = Provider.of<exmpleDatabase>(context,listen: false);
    Random random = Random.secure();

    return Scaffold(
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
                  id = random.nextInt(999999);

                  await database.CreateNewGame('$id');
                  database.setGameId('$id');
                  database.setIsCreated();

                 await showdialogForCreate(context, '$id').then((_){
                   Navigator.popAndPushNamed(context, '/gameScreen');

                 });



//                  dataservice.setId.add('$id');
//                  Provider.of<idNotifier>(context,listen: false).setId('$id');
//                  Provider.of<idNotifier>(context,listen: false).setCreated();
//                 Provider.of<exmpleDatabase>(context,listen: false).setValue(true);
//                 Provider.of<exmpleDatabase>(context,listen: false).setId('$id');


//                  Provider.of<turnProvider>(context,listen: false).setValue(true);
//                  await databaseService().setHost(id);
//                  Navigator.popAndPushNamed(context, '/gameScreen');
                }
            ),
            RaisedButton(
                child: Text('Join'),
                onPressed: () async {
                  showDialogForJoin(context).then((value)  async {
                    if(await databaseService().isDocumentAvailable(value)){
//                      final ref = Provider.of<turnProvider>(context,listen: false);
//                      ref.setValue(false);
//                      ref.setId(value);
                    print("jaydip"+value);
//                      dataservice.setId.add(value);
//                      Provider.of<idNotifier>(context,listen: false).setId(value);
                      database.setGameId(value);
                      database.setDone();
                      await databaseService().setdone(value);
                      Navigator.popAndPushNamed(context, '/gameScreen');
                    }
                  });
//                  Provider.of<turnProvider>(context,listen: false).setValue(false);
//                  await databaseService().setGuest(id);
//                  Navigator.popAndPushNamed(context, '/gameScreen');
                }
            ),
          ],
        ),
      )
    );
  }
}

class dialogWidget extends StatefulWidget {

  @override
  _dialogWidgetState createState() => _dialogWidgetState();
}

class _dialogWidgetState extends State<dialogWidget> {
  bool isLoading = false;
  String id;
  @override
  Widget build(BuildContext context) {
    return isLoading ? AlertDialog(content: Text('Loading'),

      actions: <Widget>[
        RaisedButton(
          child: Text('cancle'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    ) :AlertDialog(
      title: Text('Enter Code'),
      content: Form(
        child: TextFormField(
          onChanged:(val) => id=val,
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text('yes'),
          onPressed: () async{
            //isLoading = true;
            setState(() {
              isLoading = true;
            });


            if(id != null) {
              if(await databaseService().isDocumentAvailable(id)){

                Navigator.of(context).pop(id);

              }
            }
          },
        ),
        RaisedButton(
          child: Text('cancle'),
          onPressed: (){
            // databaseService().deleteDocument(id);
            Navigator.pop(context);
          },
        )

      ],
    );
  }
}

