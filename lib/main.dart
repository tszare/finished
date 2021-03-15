import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'httpDemo/http_demo.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor:Color(0x9F333333),
        //accentColor:Colors.red,
      ),
      home:HttpDemo(),

      //drawer: DrawDemo(),
    );
  }




}


