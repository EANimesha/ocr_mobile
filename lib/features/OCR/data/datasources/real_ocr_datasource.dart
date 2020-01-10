import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ocr_mobile/features/OCR/Buisness%20Layer/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';

class RealOcrRepository implements OcrRepository{
  @override
  Future<OcrResult> convertImageToText(File image) async {
    print('inside repo');
    // print(image.path);
    FormData formData=new FormData.from({
      "image":UploadFileInfo(image,image.path),
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5kaWxpbmk5N0BnbWFpbC5jb20iLCJfaWQiOiI1ZTBmNGNiZTAzMzZjNTAwMDRiNzZiM2MiLCJpYXQiOjE1Nzg2NDY2ODEsImV4cCI6MTU3ODY1MDI4MX0.IIvAAUPFXWbF0EjsOZuvnzeWNbyzrJndA9g0Ozv_Qaw"
    });

  try{
    Dio dio = new Dio();
    var response=await dio.post("https://ocr-system.herokuapp.com/image",data:formData);
    print(json.encode(response.data).toString());
    return OcrResultModel.fromJson(response.data);
  }catch(e){
    throw Failure("An error Occured.Please Try another photo");
  }

  }
}

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}