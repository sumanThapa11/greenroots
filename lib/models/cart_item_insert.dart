import 'package:flutter/cupertino.dart';

class CartItemInsert {
  int quantity;
  int plant;

  CartItemInsert({
    required this.quantity,
    required this.plant,
  });

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "plant": plant,
    };
  }
}
