class PlantScannerImageInsert {
  String plantImage;

  PlantScannerImageInsert({required this.plantImage});

  Map<String, dynamic> toJson() {
    return {
      "base64Image": plantImage,
    };
  }
}
