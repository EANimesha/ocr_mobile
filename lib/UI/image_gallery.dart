import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

class GalleryImage extends StatefulWidget {
  GalleryImage({Key key}) : super(key: key);

  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  File _image;

  Future getImage(ImageSource source) async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: source);


    setState(() {
      _image = image;
    });
  }
  // Future<File> imageFile;
 
  // pickImageFromGallery(ImageSource source) {
  //   setState(() {
  //     imageFile = ImagePicker.pickImage(source: source);
  //   });
  // }

  // Widget showImage() {
  //   return FutureBuilder<File>(
  //     future: imageFile,
  //     builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done &&
  //           snapshot.data != null) {
  //         return Image.file(
  //           snapshot.data,
  //           width: 300,
  //           height: 300,
  //         );
  //       } else if (snapshot.error != null) {
  //         return const Text(
  //           'Error Picking Image',
  //           textAlign: TextAlign.center,
  //         );
  //       } else {
  //         return const Text(
  //           'No Image Selected',
  //           textAlign: TextAlign.center,
  //         );
  //       }
  //     },
  //   );
  // }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // showImage(),
             Center(
               child:Container(
                 width: 300,
                 height: 300,
                  child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
               )
              ),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
            ),
            RaisedButton(
              child: Text('Convert to text'),
                onPressed: () => upload(_image, context))
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Image Picker Example'),
  //     ),
  //     body: Center(
  //       child: _image == null
  //           ? Text('No image selected.')
  //           : Image.file(_image),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: getImage,
  //       tooltip: 'Pick Image',
  //       child: Icon(Icons.add_a_photo),
  //     ),
  //   );
  // }
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
