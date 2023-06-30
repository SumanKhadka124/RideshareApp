// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   // Request permission for notifications
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   print('User granted permission: ${settings.authorizationStatus}');

//   String? token = await messaging.getToken();
//   print('FCM Token: $token');

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Received message: ${message.notification?.title}');
//     // Process the incoming message
//   });

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Push Notifications Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routes: {
//         '/': (context) => HomePage(),
//         '/notifications': (context) => NotificationsPage(),
//       },
//       initialRoute: '/',
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/notifications');
//           },
//           child: Text('Notifications'),
//         ),
//       ),
//     );
//   }
// }

// class NotificationsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: Center(
//         child: Text(
//           'Notifications Page',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

// class MyFirebaseMessagingService extends FirebaseMessagingService {
//   @override
//   Future<void> onMessage(RemoteMessage message) async {
//     super.onMessage(message);
//     // Handle the incoming message when the app is in the foreground
//     print('Received message: ${message.notification?.title}');
//     navigateToNotificationsPage();
//   }

//   @override
//   Future<void> onBackgroundMessage(RemoteMessage message) async {
//     super.onBackgroundMessage(message);
//     // Handle the incoming message when the app is in the background
//     print('Received message: ${message.notification?.title}');
//   }

//   void navigateToNotificationsPage() {
//     // You can navigate to the notifications page using the navigator key
//     // if you have a global navigator key defined in your app
//     // Example: GlobalNavigatorKey.currentState?.pushNamed('/notifications');

//     // Alternatively, you can use the context to navigate to the notifications page
//     Navigator.of(context).pushNamed('/notifications');
//   }
// }
