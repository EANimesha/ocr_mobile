import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/entities/ocr_result.dart';

class FakeOcrRepository implements OcrRepository{
  @override
   Future<OcrResult> convertImageToText(File image) async {
    print('inside repo');
    FormData formData=new FormData.from({
        "imageFile":UploadFileInfo(image,image.path),
         });

      Dio dio = new Dio();
      dio.options.headers['Apikey']='d0f6797c-49ee-402a-8586-ecc4a526e1c8';
      var response=await dio.post("https://api.cloudmersive.com/ocr/image/toText",data:formData);
      print(json.encode(response.data).toString());

    return OcrResultModel.fromJson(response.data);
    
  }

}
