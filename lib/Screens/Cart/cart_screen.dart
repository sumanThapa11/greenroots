import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/Cart/components/cart_item_delete_alert.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/users_cart_items.dart';
import 'package:greenroots/services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartService get cartService => GetIt.I<CartService>();
  String? errorMessage;
  String? emptyCart;
  late UsersCartItem usersCartItem;
  bool showSpinner = false;

  @override
  void initState() {
    setState(() {
      showSpinner = true;
    });
    cartService.getUsersCartItems().then((response) {
      setState(() {
        showSpinner = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error Occurred';
      }
      usersCartItem = response.data!;
      emptyCart = response.errorMessage;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Center(
          child: Text(
            "your cart",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          if (showSpinner) {
            return kCircularProgressIndicator;
          }
          if (emptyCart == 'emptyCart') {
            return Center(
              child: Text("The cart is empty"),
            );
          }
          return Stack(
            children: [
              ListView.separated(
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {},
                      confirmDismiss: (direction) async {
                        final result = await showDialog(
                            context: context, builder: (_) => CartItemDelete());
                        if (result) {
                          final deleteCartItem =
                              await cartService.deleteCartItem(
                                  (usersCartItem.cartItems[index]['id'])
                                      .toString());

                          var message;
                          if (deleteCartItem != null &&
                              deleteCartItem.data == true) {
                            message = 'The item was deleted successfully';
                          } else {
                            message = deleteCartItem.errorMessage ??
                                'An error occurred';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                message,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              duration: Duration(seconds: 4),
                              backgroundColor: Color(0xFF32CD32),
                            ),
                          );
                          return deleteCartItem.data ?? false;
                        }
                        return result;
                      },
                      background: Container(
                        color: Colors.red,
                        padding: EdgeInsets.only(right: 16),
                        child: Align(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      child: ListTile(
                        title: Text(usersCartItem.cartItems[index]['plant']),
                        subtitle: Text("Quantity - " +
                            (usersCartItem.cartItems[index]['quantity'])
                                .toString()),
                        trailing: Text("NPR " +
                            (usersCartItem.cartItems[index]['total'])
                                .toString()),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 1,
                        color: kPrimaryColor,
                      ),
                  itemCount: usersCartItem.cartItems.length),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/checkout', arguments: usersCartItem);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(70, 70),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                        primary: kPrimaryColor),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
