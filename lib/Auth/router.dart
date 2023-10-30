// // In your routing setup
// import 'package:flutter/material.dart';

// class MyRouter {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final String initialRoute;

//   MyRouter(this.navigatorKey, this.initialRoute);

//   static bool isAdmin = false; // Set this based on the user's role

//   Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/admin':
//         if (isAdmin) {
//           return MaterialPageRoute(builder: (context) => AdminPanel());
//         } else {
//           return MaterialPageRoute(builder: (context) => AccessDeniedPage());
//         }
//       case '/user':
//         return MaterialPageRoute(builder: (context) => UserPanel());
//       default:
//         return MaterialPageRoute(builder: (context) => NotFoundPage());
//     }
//   }
// }
