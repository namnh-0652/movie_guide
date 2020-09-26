import 'package:flutter/material.dart';

enum ViewState { Busy, Idle }

abstract class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  void setViewState(ViewState newState) {
    _state = newState;
  }
}
