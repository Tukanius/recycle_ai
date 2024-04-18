import 'package:flutter/material.dart';

class ToolsProvider extends ChangeNotifier {
  bool camera = true;

  toggleCamera(value) {
    camera = value;
    notifyListeners();
  }
}
