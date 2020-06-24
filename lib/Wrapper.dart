import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tictactoe/Models/UserModel.dart';
import 'package:tictactoe/Screen/Invitation/invitation.dart';

import 'Screen/Authenticate/sign_in.dart';

    class Wrapper extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        final user = Provider.of<User>(context);
        if(user == null){
          return SignIn();
        }
        else{
          return invitation();
        }
      }
    }
