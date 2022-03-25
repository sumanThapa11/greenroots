class UsersPlantInsert {
  String userId;
  int plantId;

  UsersPlantInsert({required this.userId, required this.plantId});

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "plant_id": plantId,
    };
  }
}
