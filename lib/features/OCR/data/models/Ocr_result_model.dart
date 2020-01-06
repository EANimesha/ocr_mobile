import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:meta/meta.dart';

class OcrResultModel extends OcrResult{
  OcrResultModel({
    @required  double meanConfidentialLevel,
    @required String textResult
  }):super(meanConfidentialLevel:meanConfidentialLevel,textResult:textResult);

  factory OcrResultModel.fromJson(Map<String,dynamic> json){
    return OcrResultModel(meanConfidentialLevel: json['MeanConfidentialevel'],textResult: json['TextResult']);
  }

  Map<String,dynamic> toJson(){
    return{
      'MeanConfidentialLevel':meanConfidentialLevel,
      'TextResult':textResult
    };
  }
}