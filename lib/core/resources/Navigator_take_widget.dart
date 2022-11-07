// ignore: file_names
import 'package:flutter/material.dart';

class NavigatorTakeWidget{

static navigatornoback(context,Widget widget){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> widget));

}
static navigatorwithback(context,Widget widget){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> widget));

}

}