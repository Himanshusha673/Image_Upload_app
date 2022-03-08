import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'login.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text(" ${FirebaseAuth.instance.currentUser?.displayName}"),
            accountEmail: Text(" ${FirebaseAuth.instance.currentUser?.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  '${FirebaseAuth.instance.currentUser?.photoURL}'),
            ),
            onDetailsPressed: () {},
            arrowColor: Colors.black,
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(padding: EdgeInsets.all(20)),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            contentPadding: EdgeInsets.all(20),
            onTap: () {},
            selected: true,
            dense: true,
            selectedTileColor: Colors.white,
            subtitle: Text("click to go homepage "),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            contentPadding: EdgeInsets.all(20),
            onTap: () {},
            dense: true,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            contentPadding: EdgeInsets.all(20),
            onTap: () {},
            dense: true,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            contentPadding: EdgeInsets.all(20),
            onTap: () async {
              await FirebaseServices().signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            dense: true,
          ),
        ],
      ),
    );
  }
}
