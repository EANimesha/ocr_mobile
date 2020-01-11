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
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbWVzaGFzZXVva0BnbWFpbC5jb20iLCJfaWQiOiI1ZTE5YmY4Yzc1MTgxMjAwMDQ1NGEzMWYiLCJpYXQiOjE1Nzg3NTkzMzgsImV4cCI6MTU3ODc2MjkzOH0.hLxHWgfxgyoHQTy2L8RNEZKqbGLoov1zFQzBInyg6zo"
    });

  try{
    Dio dio = new Dio();
    var response=await dio.post("https://ocr-system.herokuapp.com/image",data:formData);

    if(response.statusCode!=200){
      print('error');
      throw Exception('Server Error');
    }else{
      print(json.encode(response.data).toString());
      final OcrResult result=OcrResultModel.fromJson(response.data);
      if(result.status=="success"){
        return result;
      }
      throw Exception('Image Conversion Error');
    }
  }catch(e){
    print(e.toString());
    throw DioError();
  }

  }
}
