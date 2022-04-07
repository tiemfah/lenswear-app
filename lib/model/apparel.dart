class Apparel {
  String apparelID;
  String apparelTypeID;
  String name;
  String brand;
  String price;
  String storeURL;
  List<String> imageURLs;

  Apparel(
      {required this.apparelID,
      required this.apparelTypeID,
      required this.name,
      required this.brand,
      required this.price,
      required this.storeURL,
      required this.imageURLs});

  factory Apparel.fromJson(Map<String, dynamic> json) {
    return Apparel(
      apparelID: json['apparelID'],
      apparelTypeID: json['apparelTypeID'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'],
      storeURL: json['storeURL'],
      imageURLs: List<String>.from(['imageURLs']),
    );
  }

  @override
  String toString() {
    return "apparelID: $apparelID, apparelTypeID: $apparelTypeID, name: $name, brand: $brand, price: $price, storeURL: $storeURL, imageURLs: $imageURLs";
  }
}
