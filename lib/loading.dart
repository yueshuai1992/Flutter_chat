import 'package:flutter/material.dart';
import 'dart:async'; 

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() { 
    super.initState();
    new Future.delayed(
      Duration(seconds: 3),
      (){
        print("戈友中心程序启动。。。。。");
        Navigator.of(context).pushReplacementNamed("app");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          Image.asset("images/loading.jpeg", fit: BoxFit.cover,),
        ],
      )
    );
  }
}