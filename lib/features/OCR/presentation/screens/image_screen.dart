import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/convert_image_to_text.dart';
import 'package:ocr_mobile/features/OCR/presentation/bloc/ocr_bloc.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File _image;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);


    setState(() {
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Image'),
      ),
       body: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('Camera Image'),
                    onPressed:(){
                      getImage(ImageSource.camera);
                    } ,
                  ),
                  SizedBox(width: 30.0,),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text('Gallery Image'),
                    onPressed: (){
                      getImage(ImageSource.gallery);
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
                 onPressed: ()=>_upload(_image),
               )
              ,
              StreamBuilder<OcrResult>(
                stream: bloc.outOcrResult,
                builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    final result= snapshot.data;
                     bloc.dispose();
                    return Text(result.textResult);
                }),
            ],
          )
        ),
    );
  }
}

_upload(File imageFile) async {
    OcrRepository repository=FakeOcrRepository();
    ConvertImageToText convertImageToText=ConvertImageToText(repository);
    await convertImageToText.call(image: imageFile);

}

