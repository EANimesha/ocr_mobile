import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_mobile/features/OCR/data/datasources/real_ocr_datasource.dart';
import 'package:ocr_mobile/features/OCR/presentation/screens/bloc/bloc.dart';

import 'features/OCR/presentation/screens/app_screen.dart';

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
        home: BlocProvider(
          builder: (context)=>OcrBloc(RealOcrRepository()),
          child: AppScreen(),
        )
        );
  }
}

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "OPTICAL CHARACTER RECOGNITION APP",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Image.asset('assets/images/pic.png'),
          RaisedButton(
            color: Colors.black38,
            child: Text(
              "Get Started",
              style: TextStyle(color: Colors.white,fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppScreen()));
            },
          )
        ],
      ),
    );
  }
}
