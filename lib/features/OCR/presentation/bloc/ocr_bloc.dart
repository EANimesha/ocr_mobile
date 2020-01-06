import 'dart:async';

import 'package:ocr_mobile/features/OCR/domain/entities/ocr_result.dart';


class OcrBloc{
    StreamController<OcrResult> _ocrResultController=StreamController();
    Stream<OcrResult> get outOcrResult=>_ocrResultController.stream;
    Sink<OcrResult> get inOcrResult=>_ocrResultController.sink;


    void addResult(OcrResult result){
      inOcrResult.add(result);
    }

    void dispose(){
      _ocrResultController.close();
    }
}

final bloc=OcrBloc();