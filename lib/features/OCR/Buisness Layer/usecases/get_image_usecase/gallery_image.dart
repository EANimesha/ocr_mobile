import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ocr_mobile/features/OCR/Buisness Layer/usecases/get_image_usecase/image.dart';

class GalleryImage extends Picture{
  @override
  Future<File> takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

}