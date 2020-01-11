import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
      }catch(e){
        if(e is DioError){
          yield OcrErrorState("Network Error.check whether device is online");
        }else{
          yield OcrErrorState("some error occured. Try with another image");
        }
      }
    }
  }
}
