import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ocr_mobile/core/error/failures.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import './bloc.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final OcrRepository ocrRepository;

  OcrBloc(this.ocrRepository);


  @override
  OcrState get initialState => OcrInitialState();

  @override
  Stream<OcrState> mapEventToState(
    OcrEvent event,
  ) async* {
    yield OcrLoadingState();
    if(event is GetOcrResult){
      try{
        final result=await ocrRepository.convertImageToText(event.image);
        yield OcrLoadedState(result);
      }on Failure{
        yield OcrErrorState("some error occured");
      }
    }
  }
}
