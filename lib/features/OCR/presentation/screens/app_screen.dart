import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_mobile/features/OCR/presentation/bloc/bloc.dart';
import 'package:ocr_mobile/features/OCR/presentation/screens/result_screen.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR App'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  child: Text('Camera Image'),
                  onPressed: () {
                    getImage("camera",context);
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text('Gallery Image'),
                  onPressed: () {
                    getImage("gallery",context);
                  },
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: BlocBuilder<OcrBloc, OcrState>(
                builder: (context, state) {
                  if (state is OcrInitialState) {
                    return welcome();
                  } else if (state is ImageSelectedState) {
                    return displayDataAfterImageSelected(state.image,context);
                  } else {
                    return Text(' ');
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget welcome() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
         Container(
           padding: EdgeInsets.all(15.0),
           child: Text(
              'Welcome To the App!!\n Select A Image from Camera or Gallery',
              style: TextStyle(color: Colors.black,fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
         ),
      ],
    );
  }

  Widget displayDataAfterImageSelected(File image,BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          padding: EdgeInsets.all(10.0),
          child: Image.file(image),
        ),
        RaisedButton(
          child: Text("Convert to text"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<OcrBloc>(context),
                      child: ResultScreen(image),
                    )));
          },
        ),
      ],
    );
  }

   void getImage(String type,BuildContext context) {
    final ocrBloc = BlocProvider.of<OcrBloc>(context);
    ocrBloc.add(SelectImage(type));
  }
}
