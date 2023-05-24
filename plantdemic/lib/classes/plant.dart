class Plant {
  String name;
  String cost;
  String price;
  String quantity;
  String imagePath;
  String? sellQuantity;
  String? buyer;
  String? deliveryDate;

  Plant({
    required this.name,
    required this.cost,
    required this.price,
    required this.quantity,
    required this.imagePath,
    this.sellQuantity,
    this.buyer,
    this.deliveryDate,
  });

  bool isOutOfStock() {
    int currentQuantity = int.tryParse(quantity) ?? 0;
    return currentQuantity == 0;
  }

  double computeTotalPrice(int sellQuantity) {
    double plantPrice = double.tryParse(price) ?? 0;
    return plantPrice * sellQuantity;
  }
}
