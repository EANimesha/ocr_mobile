import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

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
                 onPressed: ()=>_upload(_image,context),
               )

            ],
          )
        ),
    );
  }
}

_upload(File imageFile, BuildContext context) async {
  var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();

  var uri = Uri.parse('https://api.cloudmersive.com/ocr/image/toText');

  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('imageFile', stream, length,
      filename: basename(imageFile.path));

  Map<String, String> headers = {
    'Apikey': 'a1f2608a-10c0-4dcb-9d9c-d279d345f41d'
  };
  request.headers.addAll(headers);
  request.files.add(multipartFile);

  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
    alertResult(context,value);
  });

}

Future<void> alertResult(BuildContext context, String value) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('Result'),
        content:Text(value),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}
