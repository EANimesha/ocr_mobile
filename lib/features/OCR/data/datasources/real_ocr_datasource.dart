import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';

class RealOcrRepository implements OcrRepository{
  @override
  convertImageToText(File image) async {
    OcrResult result;
    print('inside repo');
    // print(image.path);
  FormData formData=new FormData.from({
      "image":UploadFileInfo(image,'im.jpg'),
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5kaWxpbmk5N0BnbWFpbC5jb20iLCJfaWQiOiI1ZTBmNGNiZTAzMzZjNTAwMDRiNzZiM2MiLCJpYXQiOjE1Nzg1NzIwNzEsImV4cCI6MTU3ODU3NTY3MX0.SnthcUfZRdxkHjIAny3THWcMzAZGwgzHsbnnUWtuQRk"
    });
    
    try{
      Dio dio = new Dio();
      var response=await dio.post("https://ocr-system.herokuapp.com/image",data:formData);
      print(json.encode(response.data).toString());
    // if(response.statusCode==200){
    //     result= OcrResultModel.fromJson(json.decode(response.toString()));
    //     bloc.addResult(result);
    //     print(response.toString());
    // }

    }catch(e){
      print(e);
    }
    
  }
}