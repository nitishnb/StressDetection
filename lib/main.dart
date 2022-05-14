import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection/models/user.dart';
import 'package:stress_detection/screens/wrapper.dart';
import 'package:stress_detection/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}