import 'dart:io';

// import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
// import 'package:ocr_mobile/core/error/failures.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/entities/ocr_result.dart';

class ConvertImageToText{
  final OcrRepository repository;
  ConvertImageToText(this.repository);

  Future<OcrResult> call({
    @required File image,
  })async{
    return await repository.convertImageToText(image);
  }
}