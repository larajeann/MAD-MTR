import 'package:flutter/material.dart';
import 'package:alvaro_midtermproject/homeScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(Midterm());
}

class Midterm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilipiKnows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
       debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
