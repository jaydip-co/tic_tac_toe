
import 'dart:async';

import 'package:flutter/foundation.dart';

class turnProvider extends ChangeNotifier{
 bool isHost ;
 String id;
 String get getId => id;
 bool get ishost => isHost ;
 setValue(bool val){
   isHost = val;
   notifyListeners();
 }
 setId(String val){
   id= val;
   notifyListeners();
 }

}
