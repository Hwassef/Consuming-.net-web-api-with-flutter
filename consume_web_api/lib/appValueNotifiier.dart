import 'package:flutter/cupertino.dart';

class AppValueNotifier {
  ValueNotifier valueNotifier = ValueNotifier(0);
  void incrementNotifier() {
    valueNotifier.value++;
  }
}
