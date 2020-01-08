import 'package:ocr_mobile/features/OCR/domain/usecases/get_image_usecase/camera_image.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/get_image_usecase/gallery_image.dart';
import 'package:ocr_mobile/features/OCR/domain/usecases/get_image_usecase/image.dart';

class ImageFactory{
  Picture image;
  Picture getFrom(String type ){
    if(type=="camera"){
      image= CameraImage();
    }
    else if(type=="gallery"){
      image= GalleryImage();
    }
    return image;
  }
}