import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/order_insert.dart';
import 'package:greenroots/models/plant_order_insert.dart';
import 'package:greenroots/models/users_cart_items.dart';
import 'package:greenroots/services/cart_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.usersCartItem})
      : super(key: key);
  final UsersCartItem usersCartItem;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

enum PaymentType { khalti, cashOnDelivery }

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartService get cartService => GetIt.I<CartService>();
  PaymentType? _type = PaymentType.cashOnDelivery;
  final double deliveryCharge = 150;
  final deliveryAddressController = TextEditingController();
  bool plantOrderIsSuccess = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Center(
          child: Text(
            "Confirm Cart",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sub Total Amount"),
                Text("NPR " + (widget.usersCartItem.total).toString()),
              ],
            ),
          ),
          Divider(
            height: 4,
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            height: size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery charge"),
                Text("NPR " + (deliveryCharge).toString()),
              ],
            ),
          ),
          Divider(
            height: 4,
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            height: size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total amount"),
                Text("NPR " +
                    (widget.usersCartItem.total + deliveryCharge).toString()),
              ],
            ),
          ),
          Divider(
            height: 8,
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            height: size.height / 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment"),
                SizedBox(
                  width: size.width / 4,
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('khalti'),
                        dense: true,
                        leading: Radio<PaymentType>(
                          activeColor: kPrimaryColor,
                          value: PaymentType.khalti,
                          groupValue: _type,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('cash on delivery'),
                        dense: true,
                        leading: Radio<PaymentType>(
                          activeColor: kPrimaryColor,
                          value: PaymentType.cashOnDelivery,
                          groupValue: _type,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 8,
            thickness: 1,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery address"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      fillColor: kPrimaryColor,
                      focusColor: kPrimaryColor,
                    ),
                    controller: deliveryAddressController,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            height: size.width / 9,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final order = OrderInsert(
                    total: widget.usersCartItem.total + 150.00,
                    payment: _type == (PaymentType.khalti) ? 1 : 2,
                    deliveryAddress: deliveryAddressController.text);

                final result = await cartService.createOrder(order);
                if (result.data?.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(kErrorSnackBar);
                }
                final int orderId = result.data!.id;

                if (result.error != true) {
                  for (Map<String, dynamic> plant
                      in widget.usersCartItem.cartItems) {
                    PlantOrderInsert plantOrder = PlantOrderInsert(
                        quantity: plant['quantity'],
                        total: plant['total'],
                        order: orderId,
                        plant: plant['plantId']);
                    final resultOfPlantOrder =
                        await cartService.createPlantOrder(plantOrder);
                    if (resultOfPlantOrder.error != true) {
                      plantOrderIsSuccess = true;
                    }
                  }
                  if (plantOrderIsSuccess == true) {
                    final result = await cartService.deleteCart();
                    if (result.data != true) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(kErrorSnackBar);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Order placed successfully",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          duration: Duration(seconds: 4),
                          backgroundColor: Color(0xFF32CD32),
                        ),
                      );
                      Navigator.of(context).pushNamed('/home');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(kErrorSnackBar);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(kErrorSnackBar);
                }
              },
              child: Text("Confirm"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
