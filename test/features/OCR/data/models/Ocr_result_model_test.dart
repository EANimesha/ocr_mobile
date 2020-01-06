import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ocr_mobile/features/OCR/data/models/Ocr_result_model.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main(){
  final tOcrResultModel=OcrResultModel(meanConfidentialLevel: 0.95,textResult: 'Test\nText');
  test(
    'should be a subclass of OcrResult Entitiy', 
    ()async{
      expect(tOcrResultModel, isA<OcrResult>());
    });

    group('fromJson', (){
      test('should return a valid model for Json Data',
      ()async{
        final Map<String,dynamic> jsonMap=json.decode(fixtures('ocr_result.json'));

        final result= OcrResultModel.fromJson(jsonMap);

        expect(result, tOcrResultModel);
      });
    });

    group('toJson', (){
      test(
        'should return a Json Map containing the proper data', 
        ()async{
          //act
          final result= tOcrResultModel.toJson();
          //assert
          final expectedMap={
            "MeanConfidentialLevel":0.95,
            "TextResult":"Test\nText",
          };
          expect(result, expectedMap);
        });
    });
}