import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pratical2/splashscreen.dart';
import 'package:pratical2/views/screen/homepage_.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'signin_page',
      //initialRoute: 'splashscreen',
      //initialRoute: 'splashscreen',

      routes: {
        '/': (context) => HomePage(),
        // 'signin_page': (context) => SignInScreen(),
        // 'signup_page': (context) => SignUpScreen(),
        'splashscreen': (context) => SplashScreen(),
      },
    ),
  );
}

//
// void main() {
//   runApp(
//     MaterialApp(
//       home: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for Errors
//         if (snapshot.hasError) {
//           print("Something went Wrong");
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MaterialApp(
//             title: 'CRUD FIRESTORE',
//             // theme: ThemeData(
//             //   primarySwatch: Colors.bl,
//             // ),
//             debugShowCheckedModeBanner: false,
//             //initialRoute: 'splashscreen',
//             routes: {
//               '/': (context) => HomePage2(),
//               'splashscreen': (context) => SplashScreen(),
//             },
//           );
//         }
//         return const CircularProgressIndicator(
//           color: Colors.pinkAccent,
//         );
//       },
//     );
//   }
// }
