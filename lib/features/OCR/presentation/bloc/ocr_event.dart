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
