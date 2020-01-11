import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ocr_mobile/features/OCR/Buisness%20Layer/entities/ocr_result.dart';

abstract class OcrState extends Equatable {
  const OcrState();
}

class OcrInitialState extends OcrState {
  const OcrInitialState();
  @override
  List<Object> get props => [];
}

class OcrLoadingState extends OcrState {
  const OcrLoadingState();
  @override
  List<Object> get props => [];
}

class OcrLoadedState extends OcrState {
  final OcrResult ocrResult;
  const OcrLoadedState(this.ocrResult);
  @override
  List<Object> get props => [ocrResult];
}

class OcrErrorState extends OcrState {
  final String message;
  const OcrErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class ImageSelectedState extends OcrState{
  final File image;
  const ImageSelectedState(this.image);
  @override
  List<Object> get props => [image];

}