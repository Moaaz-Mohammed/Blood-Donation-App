import 'package:flutter/material.dart';

class OrderCartPriceProvider extends ChangeNotifier {
  int numberOfOrder = 1;

  incrementCounter() {
    numberOfOrder++;
    notifyListeners();
  }

  decrementCounter() {
    if (numberOfOrder > 1) {
      numberOfOrder--;
      notifyListeners();
    }
  }

  resetCounter() {
    numberOfOrder = 1;
    notifyListeners();
  }
}
