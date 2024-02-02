import 'dart:io';

import 'package:flutter/material.dart';

class AddPageProvider extends ChangeNotifier {
  File? _image;
  String? _imagePath;

  File? get image => _image;
  String? get imagePath => _imagePath;

  void setImage(File image, String imagePath) {
    _image = image;
    _imagePath = imagePath;
    notifyListeners();
  }
}
