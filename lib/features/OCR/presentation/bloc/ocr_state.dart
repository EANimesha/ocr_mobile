import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';

abstract class OcrState extends Equatable {
  OcrState([List props=const <dynamic>[]]):super(props);
}

class Empty extends OcrState {
}

class Loading extends OcrState {
}

class Loaded extends OcrState {
  final OcrResult result;
  Loaded({@required this.result}):super([result]);
}
