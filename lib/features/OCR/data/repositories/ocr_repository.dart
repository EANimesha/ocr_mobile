
import 'dart:io';
abstract class OcrRepository{
  convertImageToText(File image);
  // Future<Either<Failure,OcrResult>> convertPdfToText(File image);
}