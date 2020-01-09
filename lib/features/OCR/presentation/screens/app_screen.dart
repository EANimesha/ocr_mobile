import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocr_mobile/features/OCR/data/datasources/third_party_ocr_datasource.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_image_usecase/image.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_image_usecase/image_fatory.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_result_usecase/convert_image_to_text.dart';

class AppScreen extends StatefulWidget {
  AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {

  File _image;
  ImageFactory imageFactory=ImageFactory();
  String _result="Welcome to the App";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Image'),
      ),
       body:
          Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Camera Image'),
                      onPressed:(){
                        getImage("camera");
                      } ,
                    ),
                    SizedBox(width: 30.0,),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Gallery Image'),
                      onPressed: (){
                        getImage("gallery");
                      },
                    )
                  ],
                ),

                Container(
                   width: 300,
                   height: 300,
                    child: _image == null
                      ? Center(child:Text('No image selected.'))
                      : Image.file(_image),
                 ),

                 RaisedButton(
                   child: Text("Convert to text"),
                   onPressed: ()=>_upload(_image,context),
                 )
                ,
                Text(_result)
              ],
            )
          ),
    );
  }


void _upload(File imageFile,BuildContext context)async{
    ConvertImageToText convertImageToText=ConvertImageToText(FakeOcrRepository());
    OcrResult res=await convertImageToText.call(image: imageFile);
    this.setState(() {
      if(res!=null){
        this._result=res.textResult;
      }
    });
}
Future<void> getImage(String type) async {
    Picture picture= imageFactory.getFrom(type);
    File image = await picture.takeImage();


    setState(() {
      _image = image;
    });
  }
  
}


