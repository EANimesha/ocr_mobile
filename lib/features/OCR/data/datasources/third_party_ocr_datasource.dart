import 'dart:convert';
import 'dart:io';

import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:ocr_mobile/features/OCR/presentation/vm/ocr_bloc.dart';
import 'package:path/path.dart';


class FakeOcrRepository implements OcrRepository{
  @override
   convertImageToText(File image) async {
    OcrResult result;
    print('inside repo');
    // var stream =
    //     new http.ByteStream(DelegatingStream.typed(image.openRead()));
    // var length = await image.length();

    // var uri = Uri.parse('https://api.cloudmersive.com/ocr/image/toText');

    // var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile('imageFile', stream, length,
    //     filename: basename(image.path));

    // Map<String, String> headers = {
    //   'Apikey': 'a1f2608a-10c0-4dcb-9d9c-d279d345f41d'
    // };
    // request.headers.addAll(headers);
    // request.files.add(multipartFile);
    var stream =
      new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();

      var uri = Uri.parse('https://ocr-system.herokuapp.com/image');

      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(image.path));

      request.fields['token']='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5kaWxpbmk5N0BnbWFpbC5jb20iLCJfaWQiOiI1ZTBmNGNiZTAzMzZjNTAwMDRiNzZiM2MiLCJpYXQiOjE1Nzg0OTczNTksImV4cCI6MTU3ODUwMDk1OX0.ZISHqDdwwqILO97xNn_sr-73GIa48cNsE0jD6g-BHJw';
      request.files.add(multipartFile);

    final response = await request.send();
   

    if(response.statusCode==200){
      http.Response.fromStream(response).then((res){
        result= OcrResultModel.fromJson(json.decode(res.body));
        print(result.textResult);
        bloc.addResult(result);
      });
    }
    
  }

}
