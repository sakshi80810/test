import 'package:flutter/material.dart';
import 'package:flutter_workspace/ui/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        body:  MyLoginForm(),
      ),
    );
  }
}