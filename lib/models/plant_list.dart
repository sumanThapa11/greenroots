class PlantList {
  int id;
  String name;
  String unitPrice;
  String suitableTemperature;
  String description;
  String image;

  PlantList(
      {required this.id,
      required this.name,
      required this.unitPrice,
      required this.suitableTemperature,
      required this.description,
      required this.image});

  factory PlantList.fromJson(Map<String, dynamic> json) {
    return PlantList(
      id: json['id'],
      name: json['name'],
      unitPrice: json['unit_price'],
      suitableTemperature: json['suitable_temperature'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit_price': unitPrice,
      'suitable_temperature': suitableTemperature,
    };
  }
}
