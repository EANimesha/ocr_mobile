import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class OcrEvent extends Equatable {
  const OcrEvent();
}

class GetOcrResult extends OcrEvent{
  final File image;

  const GetOcrResult(this.image);

  @override
  List get props => [image];
}

class SelectImage extends OcrEvent{
  final String type;

  const SelectImage(this.type);

  @override
  List get props => [type];

}