import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ocr_mobile/features/OCR/Buisness%20Layer/usecases/get_image_usecase/image_fatory.dart';
import 'package:ocr_mobile/features/OCR/data/repositories/ocr_repository.dart';
import './bloc.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final OcrRepository ocrRepository;
  final ImageFactory imageFactory;

  OcrBloc(this.ocrRepository, this.imageFactory);


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
    }else if(event is SelectImage){
      try{
        final image=await imageFactory.getFrom(event.type).takeImage();
        yield ImageSelectedState(image);
      }catch(e){
        print(e.toString());
      }
    }
  }
}
