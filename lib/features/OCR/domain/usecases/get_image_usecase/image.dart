import 'dart:io';

abstract class Picture{
  Future<File> takeImage();
}