import 'package:flutter/cupertino.dart';
import 'package:task6/Screens/contacts_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/splash_view_screen.dart';

const String tableName = 'contacts';
const String columnId = 'id';
const String columnName = 'name';
const String columnNumber = 'phone';
const String columnMail = 'email';


const String splashRoute = "Helper/SplashView.dart";
const String homeRoute = "Screens/Contacts.dart";
const String loginRoute = "Screens/Login.dart";

final Map<String, Widget Function(BuildContext)> myroutes = {

  splashRoute : (context) => const SplashView(),
  homeRoute : (context) => const ContactsScreen(),
  loginRoute : (context) => const Login(),
};


