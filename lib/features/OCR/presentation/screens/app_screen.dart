import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_image_usecase/image.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_image_usecase/image_fatory.dart';
import 'package:ocr_mobile/features/OCR/presentation/bloc/bloc.dart';
import 'package:ocr_mobile/features/OCR/presentation/screens/result_screen.dart';

class AppScreen extends StatefulWidget {
  AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  File _image;
  ImageFactory imageFactory = ImageFactory();

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
          children: <Widget>[
             SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  child: Text('Camera Image'),
                  onPressed: () {
                    getImage("camera");
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text('Gallery Image'),
                  onPressed: () {
                    getImage("gallery");
                  },
                )
              ],
            ),
             SizedBox(
              height: 10.0,
            ),
            Container(
              width: 300,
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(10.0),
              child: _image == null
                  ? Center(
                      child: Text(
                      'Select a camera or Gallery Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0),
                    ))
                  : Image.file(_image),
            ),
            RaisedButton(
                child: Text("Convert to text"),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder:(_)=>BlocProvider.value(
                      value:BlocProvider.of<OcrBloc>(context),
                      child: ResultScreen(_image),
                    )
                  ));
                  },
        ),
          ],
        ),
      )),
    );
  }

  Future<void> getImage(String type) async {
    Picture picture = imageFactory.getFrom(type);
    File image = await picture.takeImage();

    setState(() {
      _image = image;
    });
  }
}
