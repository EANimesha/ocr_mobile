import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ocr_mobile/core/error/failures.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';

abstract class OcrRepository{
  Future<Either<Failure,OcrResult>> convertImageToText(File image);
  // Future<Either<Failure,OcrResult>> convertPdfToText(File image);
}