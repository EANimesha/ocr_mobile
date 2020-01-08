import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/convert_image_to_text.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final ConvertImageToText convertImageToText;

  OcrBloc({@required this.convertImageToText})
      : assert(convertImageToText != null);

  @override
  OcrState get initialState => Empty();

  @override
  Stream<OcrState> mapEventToState(
    OcrEvent event,
  ) async* {
    yield Loading();
    if(event is ConvertImageToText){
      final res=await convertImageToText(image:event.props[0]);
      yield Loaded(result: res);
    } 
  }
}
