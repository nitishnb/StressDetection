import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection/screens/authenticate/authenticate.dart';
import 'package:stress_detection/screens/home/home.dart';
import 'package:stress_detection/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1>(context);
    // return either home or authenticate widget
    // ignore: unnecessary_null_comparison
    if(user == null){
      print(user);
      return Authenticate();
    } else {
      print(user.toString());
      return MyHomePage();
    }
  }
}