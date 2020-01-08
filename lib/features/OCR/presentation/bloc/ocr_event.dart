import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class OcrEvent extends Equatable {
  OcrEvent([List props=const <dynamic>[]]):super(props);
}

//event call when button click
class ConvertToText extends OcrEvent{
  final File image;
  ConvertToText(this.image);

  // @override
  // List<Object> get props=>[image];
}