import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/screens/home.dart';
import 'package:firstapp/screens/registration.dart';
import 'package:firstapp/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final emailField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: const BorderSide(
                width: 2.0,
              )),

          fillColor: Colors.black.withOpacity(0.6),
          //used for inside color
          filled: true,
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "Email",
          labelStyle: const TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your email address",

          prefixIcon: Icon(Icons.email),
        ),
        onSaved: (value) {
          emailController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("please Enter a valid email");
          }
          if (!RegExp(
                  "^[a-zA-Z0-9_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)")
              .hasMatch(value)) {
            return ("please Enter a valid Email");
          }
          return null;
        },
      ),
    );

    final passwordField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        obscureText: true,
        controller: passwordController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: const BorderSide(
                width: 2.0,
              )),
          fillColor: Colors.black.withOpacity(0.6),
          //used for inside color
          filled: true,
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "Password",
          labelStyle: const TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your Password",

          prefixIcon: Icon(Icons.password_sharp),
        ),
        onSaved: (value) {
          passwordController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ('please Enter your password');
          }
          if (value.length < 8) {
            return ('your password must be atleast 8 character');
          }
          return null;
        },
      ),
    );
    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: Colors.red,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        onPressed: () {
          HomePage.myname = true;

          siginIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/Login.png",
                fit: BoxFit.fitWidth,
                cacheHeight: 315,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    " User Login",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              emailField,
              SizedBox(
                height: 10.0,
              ),
              passwordField,
              SizedBox(
                height: 20.0,
              ),
              // LoginButton
              loginbutton,
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "forgot password? ",
                    style: TextStyle(color: Colors.black87),
                  ),
                  GestureDetector(
                    child: Text(
                      "SignIn ",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(90, 15, 90, 8),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black26;
                    }
                    return Colors.white12;
                  })),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/google.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Login with Gmail",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void siginIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
