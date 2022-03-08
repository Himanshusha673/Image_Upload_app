import 'package:firstapp/images_content/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firstapp/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyScreens());
}

class MyScreens extends StatefulWidget {
  const MyScreens({Key? key}) : super(key: key);

  @override
  _MyScreensState createState() => _MyScreensState();
}

class _MyScreensState extends State<MyScreens> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 46, 87, 110),
      ),
      title: 'Herosha',
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
