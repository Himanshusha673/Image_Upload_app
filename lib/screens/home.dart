import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/images_content/image_show.dart';
import 'package:firstapp/images_content/image_upload.dart';
import 'package:firstapp/model/user_model.dart';
import 'package:firstapp/screens/login.dart';
import 'package:firstapp/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  static bool myname = false;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool myname = false;
  String name = "";
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  HomePage() {
    this.myname;
  }

  void initstate() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.from(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Mydrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              myname
                  ? "${loggedInUser.firstName} ${loggedInUser.lastName}"
                  : "welcome ${FirebaseAuth.instance.currentUser?.displayName}",
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              Image_Upload(userid: loggedInUser.uid))));
                },
                child: Text(
                  "UpLoad your image",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ImageShow(
                                userId: loggedInUser.uid,
                              ))));
                },
                child: Text(
                  "Show your image",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
