class PlantOrderInsert {
  int quantity;
  double total;
  int order;
  int plant;

  PlantOrderInsert(
      {required this.quantity,
      required this.total,
      required this.order,
      required this.plant});

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "total": total,
      "order": order,
      "plant": plant
    };
  }
}
