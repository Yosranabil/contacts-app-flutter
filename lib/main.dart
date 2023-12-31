import 'package:flutter/material.dart';
import 'Helper/constants.dart';
import 'Screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splashRoute,
      routes: myroutes,
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}