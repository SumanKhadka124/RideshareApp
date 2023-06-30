// ignore_for_file: prefer_const_constructors
// ignore: unused_import
import 'dart:async';

//This is for importing from firebase
import 'package:bhatbhate/firebase/loginf.dart';
//This was done for importing from api reqres.in
//different file login.dart is for this.
//import 'package:bhatbhate/login.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print('FCM Token:$token');
  runApp(BHATbhateApp());
}

class BHATbhateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BHATBHATEs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => LoginPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SequenceAnimation _sequenceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 1, end: 1.5),
          from: Duration.zero,
          to: const Duration(milliseconds: 500),
          tag: 'scale',
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 1.5, end: 1),
          from: const Duration(milliseconds: 500),
          to: const Duration(milliseconds: 1000),
          tag: 'scale',
        )
        .animate(_controller);

    _controller.forward().whenComplete(() {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 233, 196),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                final scale = _sequenceAnimation['scale'].value;
                return Transform.scale(
                  scale: scale,
                  child: Image.asset(
                    'assets/splash.png',
                    width: 200,
                    height: 200,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Without animation for the spalsh screen
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(context, '/home');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 210, 233, 196),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/splash.png', // Splash image
//                 width: 200,
//                 height: 200,
//                 //fit: BoxFit.fill,
//               ),
//             ),
//             // SizedBox(height: 200),
//             // Center(
//             //   child: Text(
//             //     'RIDE WITH US',
//             //     style: TextStyle(
//             //       fontSize: 24,
//             //       fontWeight: FontWeight.bold,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
