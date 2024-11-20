import 'package:flutter/widgets.dart';

class NoteState extends ChangeNotifier {
  var _currentValue = "";

  void onNotesChanged(String value) {
    print("Old Value: ${_currentValue}");
    print("New Value: ${value}");
    _currentValue = value;
    _saveLocally();
  }

  //TODO: submit notes when app minimizes, closes, sync/submit button pressed, time interval
  void onNotesSubmitted(){
    print("Submitted Notes with value: ${_currentValue}");
    _saveLocally();
    _saveUpload();
  }

  void _saveLocally(){
    print("Not implemented yet");
  }

  void _saveUpload(){
    print("Not Implemented Yet");
  }
}