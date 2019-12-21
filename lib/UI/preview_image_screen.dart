import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            RaisedButton(
                child: Text('Convert to text'),
                onPressed: () => upload(File(widget.imagePath), context))
          ],
        ),
      ),
    );
  }
}

upload(File imageFile, BuildContext context) async {
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

Future<Void> alertResult(BuildContext context, String value) {
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
