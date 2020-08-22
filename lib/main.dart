import 'package:do_it/screens/list_selection.dart';
import 'package:flutter/material.dart';
import 'package:do_it/models/models.dart';
import 'package:do_it/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FileSession>(
      create: (context) => FileSession(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomeScreen(),
          '/home': (context) => HomeScreen(),
          '/list_selection': (context) => ListSelection(),
        },
      ),
    );
  }
}
