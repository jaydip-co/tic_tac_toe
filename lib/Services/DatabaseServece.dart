
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/ennum/ennums.dart';
import 'dart:core';

class databaseService{

  String uid;
  databaseService({this.uid});

  final CollectionReference _ref = Firestore.instance.collection("playing");

  Future setValue(String id,int index,int value,bool ishost) async {
    try {
      if(ishost) {
        return await _ref.document(id).updateData({
          '$index': 30,
          'host': 0,
          'guest': 1,
        });
      }
      else{
        return await _ref.document(id).updateData({
          '$index' : 30,
          'guest' : 0,
          'host' : 1,
        });
      }
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }



  //stream for playing
//  Stream<List<int>> get values{
//    return _ref.document(uid).snapshots().map(_convetSnapsortToList);
//  }



  //Stream for single value
  Stream<DocumentSnapshot> get signleValue {
    return _ref.document(uid).snapshots();
  }

  Stream<DocumentSnapshot> get ValueTest {
    return _ref.document('376342').snapshots();
  }

  //delete document inside refrence
  Future deleteDocument(String id) {
    _ref.document(id).delete();
  }


  Future<bool> isDocumentAvailable(String id ) async{
    DocumentSnapshot doc = await _ref.document(id).get();

//    print(doc);
    if (doc.exists){
      return true;
    }
    else{
      return false;
    }
  }
  // stream for Conformation
  int _fromSnapshotToInt(DocumentSnapshot documentSnapshot){
    return documentSnapshot.data['done'];
  }

  Stream<int> waitFromCoonfermation(String id) {


    return _ref.document(id).snapshots().map(_fromSnapshotToInt);
  }

  Future CreateNewGame(String id) async {
    return await _ref.document(id).setData({
      '1' : 4,
      '2' : 4,
      '3' : 4,
      '4' : 4,
      '5' : 4,
      '6' : 4,
      '7' : 4,
      '8' : 4,
      '9' : 4,
      'host': 1,
      'guest':0,
      'done' : 0
    });
  }
  //set done for waiting
  Future setdone(String id) async{
    return await _ref.document(id).updateData({
      'done' : 1
    });
  }
}