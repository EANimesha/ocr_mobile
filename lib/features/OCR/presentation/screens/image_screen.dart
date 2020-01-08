import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ocr_mobile/features/OCR/data/datasources/third_party_ocr_datasource.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/convert_image_to_text.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/get_image_usecase/image.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/get_image_usecase/image_fatory.dart';
import 'package:ocr_mobile/features/OCR/presentation/vm/ocr_bloc.dart';

class ImageScreen extends StatefulWidget {
  ImageScreen({Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  File _image;
  ImageFactory imageFactory=ImageFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Image'),
      ),
       body: 
      //  BlocProvider<OcrBloc>(
      //     builder: (context)=>_bloc,
      //     child: 
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
                   onPressed: ()=>_upload(_image),
                 )
                ,
                StreamBuilder<OcrResult>(
                  stream: bloc.outOcrResult,
                  builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return CircularProgressIndicator();
                      }
                      else{
                      final result= snapshot.data;
                      //  bloc.dispose();
                      return Text(result.textResult);
                      }
                  }),
                // BlocBuilder<OcrBloc,OcrState>(
                //   bloc: _bloc,
                //   builder: (context,state){
                //     if(state is Empty){
                //       return Text('Start Seaarching');
                //     }
                //     else if(state is Loaded){
                //       return CircularProgressIndicator();
                //     }
                //     else if(state is Loaded){
                //       return Text(state.result.textResult);
                //     }else{
                //       return Text('Hello');
                //     }
                //   },
                // )
              ],
            )
          ),
      //  ),
    );
  }


_upload(File imageFile) async{
    OcrRepository repository=FakeOcrRepository();
    // OcrRepository repository=RealOcrRepository();
    ConvertImageToText convertImageToText=ConvertImageToText(repository);
    await convertImageToText.call(image: imageFile);
    // final blocOcr=BlocProvider.of<OcrBloc>(context);
    // blocOcr.dispatch(ConvertToText(imageFile));
}
Future getImage(String type) async {
    Picture picture= imageFactory.getFrom(type);
    File image = await picture.takeImage();


    setState(() {
      _image = image;
    });
  }
  
}


