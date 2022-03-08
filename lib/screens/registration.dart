import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        controller: firstNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: new BorderSide(
                width: 2.0,
              )),

          //used for inside color
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "First Name",
          labelStyle: new TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your First Name",

          prefixIcon: Icon(Icons.person_add_alt_1),
        ),
        onSaved: (value) {
          firstNameController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter your Name");
          }
          if (value.length < 3) {
            return ("Your name is too short");
          }
          return null;
        },
      ),
    );
    final lastNameField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        controller: lastNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: new BorderSide(
                width: 2.0,
              )),

          //used for inside color
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "Last Name",
          labelStyle: new TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your Last Name",

          prefixIcon: Icon(Icons.person_add_alt_1_rounded),
        ),
        onSaved: (value) {
          lastNameController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter yourn Last Name");
          }
          return null;
        },
      ),
    );

    final emailField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: new BorderSide(
                width: 2.0,
              )),

          //used for inside color
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "Email",
          labelStyle: new TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your Email",

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
        textInputAction: TextInputAction.next,
        obscureText: true,
        autofocus: false,
        controller: passwordController,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: new BorderSide(
                width: 2.0,
              )),

          //used for inside color
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: " Password",
          labelStyle: new TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: "Enter your password",

          prefixIcon: Icon(Icons.vpn_key),
        ),
        onSaved: (value) {
          firstNameController.text = value!;
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
    final confirmPasswordField = Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 15.0, 32.0, 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: true,
        autofocus: false,
        controller: confirmPasswordController,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
              borderSide: new BorderSide(
                width: 2.0,
              )),

          //used for inside color
          contentPadding: EdgeInsets.all(10),
          // this used for set size of our textformfield
          labelText: "confirm Password",
          labelStyle: new TextStyle(
              color: Colors.orangeAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
          hintText: " Please confrim  your Password",

          prefixIcon: Icon(Icons.vpn_key_sharp),
        ),
        onSaved: (value) {
          firstNameController.text = value!;
        },
        validator: (value) {
          if (confirmPasswordController.text != passwordController.text) {
            return ("Passwords not matched");
          }
          return null;
        },
      ),
    );
    final signUpbuttonfield = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: Colors.red,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        onPressed: () {
          HomePage.myname = true;

          signUp(emailController.text, passwordController.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              firstNameField,
              SizedBox(
                height: 20.0,
              ),
              lastNameField,
              SizedBox(
                height: 20.0,
              ),
              emailField,
              SizedBox(
                height: 20.0,
              ),
              passwordField,
              SizedBox(
                height: 20.0,
              ),
              confirmPasswordField,
              SizedBox(
                height: 50.0,
              ),
              signUpbuttonfield,
            ]),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailstToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailstToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    //writing all the values
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Acoount Created Successfuly");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
