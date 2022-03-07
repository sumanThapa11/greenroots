import 'package:flutter/material.dart';

class CartItemDelete extends StatelessWidget {
  const CartItemDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Warning"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text("Yes"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text("No"),
        ),
      ],
    );
  }
}
