import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class OcrResult extends Equatable{
  final double meanConfidentialLevel;
  final String textResult;

  OcrResult({
    @required this.meanConfidentialLevel,
    @required this.textResult
  });

  List<Object> get props=>[
    meanConfidentialLevel,
    textResult
  ];
}