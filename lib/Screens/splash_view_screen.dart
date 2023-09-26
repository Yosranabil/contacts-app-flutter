import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task6/services/shared_preferences_service.dart';

import '../Helper/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final PrefService _prefService = PrefService();

  @override
  void initState() {

    _prefService.readCache("password").then((value){

      if(value != null){
        return Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushNamed(homeRoute));
      }else
        {
          return Timer(
              const Duration(seconds: 2),
                  () => Navigator.of(context).pushNamed(loginRoute));
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFFAB72C0),
          strokeWidth: 7,
        )
      ),
    );
  }
}
