import 'package:flutter/material.dart';

class starting extends StatefulWidget {
  @override
  _startingState createState() => _startingState();
}

class _startingState extends State<starting> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.popAndPushNamed(context, '/wrapper');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterLogo(size: 200,),
    );
  }
}
