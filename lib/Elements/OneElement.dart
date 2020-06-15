import 'package:flutter/material.dart';


class OneElement extends StatelessWidget {
  OneElement({this.value});
  final int value;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$value',
        style: TextStyle(fontSize: 70),),
    );
  }
}
