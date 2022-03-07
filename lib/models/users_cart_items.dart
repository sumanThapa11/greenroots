class UsersCartItem {
  double total;
  List cartItems;

  UsersCartItem({required this.total, required this.cartItems});

  factory UsersCartItem.fromJson(Map<String, dynamic> item) {
    return UsersCartItem(total: item['total'], cartItems: item['cart_item']);
  }
}
