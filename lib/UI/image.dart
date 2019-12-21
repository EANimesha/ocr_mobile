import 'package:flutter/material.dart';
import 'package:ocr_mobile/UI/image_camera.dart';
import 'package:ocr_mobile/UI/image_gallery.dart';

class AppImage extends StatelessWidget {
  const AppImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('OCR App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text('Camera Image'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>CameraImage()));
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Gallery Image'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>GalleryImage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
