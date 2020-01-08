import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/presentation/vm/ocr_bloc.dart';

class RealOcrRepository implements OcrRepository{
  @override
  convertImageToText(File image) async {
    OcrResult result;
    print('inside repo');
    String fileName = image.path.split('/').last;
    print(image.path);
  FormData formData=new FormData.fromMap({
      "image":await MultipartFile.fromFile(image.path,filename: fileName),
      "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5kaWxpbmk5N0BnbWFpbC5jb20iLCJfaWQiOiI1ZTBmNGNiZTAzMzZjNTAwMDRiNzZiM2MiLCJpYXQiOjE1Nzg0OTczNTksImV4cCI6MTU3ODUwMDk1OX0.ZISHqDdwwqILO97xNn_sr-73GIa48cNsE0jD6g-BHJw"
    });
    
    Dio dio = new Dio();
    var response=await dio.post("https://ocr-system.herokuapp.com/image",data:formData);

    if(response.statusCode==200){
        result= OcrResultModel.fromJson(json.decode(response.toString()));
        bloc.addResult(result);
        print(response.toString());
    }
  }
}