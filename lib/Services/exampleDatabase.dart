import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:tictactoe/WinCheck.dart';
class exmpleDatabase{
  int selected = 0;
  //variables......
  StreamSubscription  _subscription;
  String _gameid;
  bool isCreated = false;
  Function eq = const ListEquality().equals;
  List<int> values = List<int>();
  final CollectionReference _ref = Firestore.instance.collection("playing");
  exmpleDatabase() {
  }

  //values update Functions....
  String get getId => _gameid;
  setGameId(String s){
    _gameid = s;
   // print("id setted....$_gameid");
  }
  setIsCreated(){
    isCreated = true;
  }
  //initial values...
  Future CreateNewGame(String id) async {
    isCreated = true;
    return await _ref.document(id).setData({
      '1' : 0,
      '2' : 0,
      '3' : 0,
      '4' : 0,
      '5' : 0,
      '6' : 0,
      '7' : 0,
      '8' : 0,
      '9' : 0,
      '10': 1,
      'done' : 0
    });
  }
  //updateValues
  Future setValueAndTurn(int index) async{

    int updateValue ;
    int turn;
    final listIndex = index - 1 ;
    values.removeAt(listIndex);
    if(isCreated){
      values.insert(listIndex, 1);
      updateValue = 1;
      turn = 0;
    }
    else{
      //1 karvanu
      values.insert(listIndex, 2);
      updateValue = 2;
      turn = 1;
    }
    selected = selected + 2;
    if(selected > 9){
      return _ref.document(_gameid).updateData({
        'win': 2,  //two for draw
      });
    }
    //checking for win.......
    bool win = WinCheck().checkForWin(values);
    if(win){
      print('win');
      return _ref.document(_gameid).updateData({
        '$index' : updateValue,
        '10' : turn,
        'win': 1, //one for win
        'winner' : isCreated ? 1 : 2,
      });
    }
    else {
      return _ref.document(_gameid).updateData({
        '$index': updateValue,
        '10': turn,
      });
    }
  }
  //set done for joining......
  Future setDone(){
    return _ref.document(_gameid).updateData({
      'done' : 1,
    });
  }

  Future<int> get getResult async {
    final data = await _ref.document(_gameid).get();
    int val = data.data['winner'];
    if(isCreated){
      switch(val){
        case 1:
          return 1;
          break;
        case 2:
          return 0;
          break;
      }
    }
    else{
      switch(val){
        case 1:
          return 0;
          break;
        case 2:
          return 1;
          break;
      }
    }
  }




  //streams and listeners.......
  final _waitingController = StreamController<int>.broadcast();
  Stream<int> get waiting => _waitingController.stream;



  StreamController<List<int>> _outputValues = StreamController.broadcast();
  Stream<List<int>>  get getValues  => _outputValues.stream;
  StreamController<int> _winController = StreamController.broadcast();
  Stream<int> get Win => _winController.stream;

  startListening(){
    print('started....');
    print("current id$_gameid");
    if(_subscription != null){
      _subscription.cancel();
      print(_subscription);
      _subscription = null;
    }
    if(_subscription == null){
      _subscription = _ref.document(_gameid).snapshots().listen((snapshot) {

        values = [0,0,0,0,0,0,0,0,0,0];
        if(snapshot != null){
          if(snapshot.data['win'] == 1){
            _winController.add(1);
          }
          snapshot.data.forEach((key, value) {
            if(key != 'done' && key != '10' && key != 'win' && key != 'winner'){
              final index= int.parse(key) - 1;
              values.removeAt(index);
              values.insert(index, value);
            }
            else if(key == '10'){
              final index = int.parse(key) - 1;
              values.removeAt(index);
              if(isCreated){
                if(value == 1){values.insert(index, 1);}
                else{values.insert(index, 0);}

              }
              else{
                if(value == 1){values.insert(index, 0);}
                else{values.insert(index, 1);}
              }
            }
          }
          );
        }
        print(values);
        _outputValues.add(values);
      });
    }
  }
}