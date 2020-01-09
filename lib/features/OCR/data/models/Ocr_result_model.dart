import 'package:ocr_mobile/features/OCR/Buisness Layer/entities/ocr_result.dart';
import 'package:meta/meta.dart';

class OcrResultModel extends OcrResult{
  OcrResultModel({
    @required  String status,
    @required String textResult
  }):super(status:status,textResult:textResult);

  factory OcrResultModel.fromJson(Map<String,dynamic> json){
    return OcrResultModel(status: json['Status'],textResult: json['TextResult']);
  }

  Map<String,dynamic> toJson(){
    return{
      'Status':status,
      'TextResult':textResult
    };
  }
}