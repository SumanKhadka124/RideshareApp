// ignore_for_file: prefer_const_constructors

import 'package:bhatbhate/firebase/loginf.dart';
import 'package:bhatbhate/firebase/signupf.dart';
//import for reqres.in
//import 'package:bhatbhate/login.dart';
//import 'package:bhatbhate/signn.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePagee(),
  ));
}

class HomePagee extends StatefulWidget {
  const HomePagee({super.key});

  @override
  State<HomePagee> createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 233, 196),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "WELCOME ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    " PLEASE LOGIN OR SIGNUP TO CONTINUE",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  )
                ],
              ),
              // Container(),
              Column(children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  width: 380,
                  height: 380,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.greenAccent,
                  height: 60,
                  minWidth: 120,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black)),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  height: 60,
                  minWidth: 120,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black)),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
