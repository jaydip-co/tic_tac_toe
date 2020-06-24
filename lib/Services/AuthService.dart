

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictactoe/Models/UserModel.dart';

class Authservice{
      final FirebaseAuth _auth = FirebaseAuth.instance;


      //method to conver the firebase auth to user model
      User _fromFireBaseUsertoUser(FirebaseUser user){
            return user == null ? null : User(uid: user.uid);
      }

      //stream for user state
      Stream<User> get user {
            return _auth.onAuthStateChanged.map(_fromFireBaseUsertoUser);
      }


      //sign in withot Email
      Future SignInAno() async {
      try{
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser  user = result.user;
      return user;
      }
      catch(e){
        print(e.toString());
        return null;
      }
      }
      //sign Out
      Future Signout() async {
            try {
                  return _auth.signOut();
            }
            catch(e)
            {
                  print(e.toString());
            }
      }
}