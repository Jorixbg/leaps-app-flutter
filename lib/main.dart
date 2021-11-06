
import 'package:flutter/material.dart';
import 'package:leaps_app/widgets/EventsWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaps',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: EventsWidget(),
    );
  }
}
