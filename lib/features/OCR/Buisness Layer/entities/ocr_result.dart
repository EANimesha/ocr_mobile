import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class OcrResult extends Equatable{
  final String status;
  final String textResult;

  OcrResult({
    @required this.status,
    @required this.textResult
  });

  List<Object> get props=>[
    status,
    textResult
  ];
}