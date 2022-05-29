import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection/models/user.dart';
import 'package:stress_detection/screens/authenticate/authenticate.dart';
import 'package:stress_detection/screens/authenticate/login.dart';
import 'package:stress_detection/screens/home/home.dart';
import 'package:stress_detection/screens/wrapper.dart';
import 'package:stress_detection/services/auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserId>.value(
      value: AuthService().userId,
      initialData: UserId(uid: ''),
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}