
import 'package:flutter/foundation.dart';
class SwitchState extends ChangeNotifier {
  bool isSwitched = false;

  void toggleSwitch() {
    isSwitched = !isSwitched;
    notifyListeners();
  }
}
