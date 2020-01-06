import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';
import 'package:ocr_mobile/features/OCR/domain/repositories/ocr_repository.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/convert_image_to_text.dart';

class MockOcrRepository extends Mock implements OcrRepository{

}

void main(){
  ConvertImageToText usecase;
  MockOcrRepository mockOcrRepository;

  setUp((){
    mockOcrRepository =MockOcrRepository();
    usecase=ConvertImageToText(mockOcrRepository);
  });
   
  final tFile=File('');
  final tOcrResult=OcrResult(meanConfidentialLevel: 0.95, textResult: 'test text',);

  test(
    'should get OcrResult for image file from the repository',
     ()async{
       when(mockOcrRepository.convertImageToText(any))
       .thenAnswer((_)async=>Right(tOcrResult));

      final result=await usecase(image:tFile);

      expect(result, Right(tOcrResult));
      verify(mockOcrRepository.convertImageToText(tFile));
      verifyNoMoreInteractions(mockOcrRepository);
     });
}