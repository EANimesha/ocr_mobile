import 'package:meta/meta.dart';

class OcrResult{
  final double meanConfidentialLevel;
  final String textResult;

  OcrResult({
    @required this.meanConfidentialLevel,
    @required this.textResult
  });
}