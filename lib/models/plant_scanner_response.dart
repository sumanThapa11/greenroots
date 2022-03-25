class PlantScannerResponse {
  int plantId;
  String plantName;

  PlantScannerResponse({required this.plantId, required this.plantName});

  factory PlantScannerResponse.fromJson(Map<String, dynamic> jsonData) {
    return PlantScannerResponse(
      plantId: jsonData['id'],
      plantName: jsonData['name'],
    );
  }
}
