import 'package:flutter/material.dart';

class DesktopNavProvider extends ChangeNotifier {
  Map? _selectedWiget;

  Map? get selectedWiget => _selectedWiget;

  void selectWiget(Map item) {
    _selectedWiget = item;
    notifyListeners();
  }
}
