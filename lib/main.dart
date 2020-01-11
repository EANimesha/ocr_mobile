import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_mobile/features/OCR/data/datasources/real_ocr_datasource.dart';
import 'package:ocr_mobile/features/OCR/presentation/screens/launch_screen.dart';
import 'features/OCR/presentation/bloc/bloc.dart';

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
        home: BlocProvider<OcrBloc>(
          builder: (context)=>OcrBloc(RealOcrRepository()),
          child: LaunchScreen(),
        )
        );
  }
}

