class CategoryList {
  int id;
  String name;
  String image;
  String description;
  int numberOfPlants;
  List plants;

  CategoryList({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.numberOfPlants,
    required this.plants,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        description: json['description'],
        numberOfPlants: json['numberOfPlants'],
        plants: json['plants']);
  }
}
