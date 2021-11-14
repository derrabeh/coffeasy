import 'package:coffeasy/APP/landing_page.dart';
import 'package:coffeasy/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Coffeasy',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        home: LandingPage(),
      ),
    );
  }
}

