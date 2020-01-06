import 'package:flutter/material.dart';
import 'package:ocr_mobile/features/OCR/presentation/screens/image_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageScreen(),
    );
  }
}
