import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ocr_mobile/core/error/failures.dart';
import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

abstract class OcrRepository{
  Future<Either<Failure,OcrResult>> convertImageToText(File image);
  // Future<Either<Failure,OcrResult>> convertPdfToText(File image);
}

class FakeOcrRepository implements OcrRepository{
  OcrResult result;
  @override
  Future<Either<Failure, OcrResult>> convertImageToText(File image) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();

    var uri = Uri.parse('https://api.cloudmersive.com/ocr/image/toText');

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('imageFile', stream, length,
        filename: basename(image.path));

    Map<String, String> headers = {
      'Apikey': 'a1f2608a-10c0-4dcb-9d9c-d279d345f41d'
    };
    request.headers.addAll(headers);
    request.files.add(multipartFile);

    var response = await request.send();
    
    http.Response.fromStream(response).then((res){
      result=OcrResultModel.fromJson(json.decode(res.body));
    });
    return null;
  }

}