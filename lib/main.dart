import 'package:coffeasy/APP/landing_page.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffeasy',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LandingPage(
        //we can only create instances of non-abstract classes
        //afterwards, can refer to auth using abstract classes
        auth: Auth(),
      ),
    );
  }
}

