import 'package:flutter/material.dart';

class CartTotalPriceProvider extends ChangeNotifier {
  late double cartTotalPrice;

  totalPrice(int price) {
    cartTotalPrice += price;
  }

}
