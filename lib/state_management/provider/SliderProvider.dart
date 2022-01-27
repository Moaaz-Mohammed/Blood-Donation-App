import 'package:flutter/cupertino.dart';

class SliderProvider extends ChangeNotifier {
  double currentIndexDots = 0;

  void increaseCounter() {
    currentIndexDots++;
    notifyListeners();
  }

  void reCounter() {
    currentIndexDots = 0;
    notifyListeners();
  }

}

