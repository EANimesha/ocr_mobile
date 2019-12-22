import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocr_mobile/core/error/failures.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/domain/repositories/ocr_repository.dart';

class ConvertImageToText{
  final OcrRepository repository;
  ConvertImageToText(this.repository);

  Future<Either<Failure,OcrResult>> call({
    @required File image,
  })async{
    return await repository.convertImageToText(image);
  }
}