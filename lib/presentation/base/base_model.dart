import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void setViewState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}

enum ViewState { Idle, Busy }
