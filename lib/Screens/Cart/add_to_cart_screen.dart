import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/cart_item_insert.dart';
import 'package:greenroots/models/category_list.dart';
import 'package:greenroots/models/plant_list.dart';
import 'package:greenroots/services/cart_service.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({Key? key, required this.plant}) : super(key: key);

  final Map<String, dynamic> plant;

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  CartService get cartService => GetIt.I<CartService>();

  final quantityController = TextEditingController(text: '0');
  double totalPrice = 0;

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          width: size.width / 1.4,
          height: size.height / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                widget.plant['name'],
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                color: Colors.grey,
                height: 10,
              ),
              SizedBox(
                height: 15,
              ),
              Text("Quantity"),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                height: 25,
                width: size.width / 4,
                child: TextField(
                  controller: quantityController,
                  inputFormatters: [LengthLimitingTextInputFormatter(2)],
                  keyboardType: TextInputType.number,
                  // autofocus: true,
                  cursorColor: Colors.black,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    fillColor: Colors.grey,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        totalPrice = double.parse(value) *
                            double.parse(widget.plant['unit_price']);
                      });
                    } else {
                      setState(() {
                        totalPrice = 0;
                      });
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price"),
                  Container(
                    height: 40,
                    width: size.width / 2.5,
                    alignment: Alignment.center,
                    color: Colors.grey.shade200,
                    child: Text(
                      "NPR " + (totalPrice).toString(),
                      style: TextStyle(
                        color: Color(0xFF32CD32),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    if (int.parse(quantityController.text) > 0) {
                      final result = await cartService.createCart();

                      final cartItem = CartItemInsert(
                          quantity: int.parse(quantityController.text),
                          plant: widget.plant['id']);

                      final result1 =
                          await cartService.createCartItem(cartItem);
                      print(result1.data);
                      if (result1.data == true &&
                          result1.errorMessage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Item added successfully",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            duration: Duration(seconds: 4),
                            backgroundColor: Color(0xFF32CD32),
                          ),
                        );
                        Navigator.pop(context);
                      } else if (result1.data == true &&
                          result1.errorMessage == "alreadyExists") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Item already exists in the cart",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            duration: Duration(seconds: 4),
                            backgroundColor: Color(0xFF32CD32),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF32CD32)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
