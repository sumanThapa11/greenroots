import 'dart:ffi';

class OrderInsert {
  var id;
  double total;
  int payment;
  String deliveryAddress;

  OrderInsert(
      {this.id,
      required this.total,
      required this.payment,
      required this.deliveryAddress});

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "payment": payment,
      "delivery_address": deliveryAddress,
    };
  }

  factory OrderInsert.fromJson(Map<String, dynamic> jsonData) {
    return OrderInsert(
        id: jsonData['id'],
        total: double.parse(jsonData['total']),
        payment: jsonData['payment'],
        deliveryAddress: jsonData['delivery_address']);
  }
}
