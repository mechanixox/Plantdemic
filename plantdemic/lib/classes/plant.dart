class Plant {
  String name;
  String price;
  String quantity;
  String imagePath;

  Plant({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  void decrementQuantity() {
    int currentQuantity = int.tryParse(quantity) ?? 0;
    if (currentQuantity > 0) {
      currentQuantity--;
      quantity = currentQuantity.toString();
    }
  }

  bool isOutOfStock() {
    int currentQuantity = int.tryParse(quantity) ?? 0;
    return currentQuantity == 0;
  }
}
