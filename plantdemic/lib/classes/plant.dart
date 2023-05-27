class Plant {
  String name;
  String cost;
  String price;
  String quantity;
  String imagePath;
  String? sellQuantity;
  String? buyer;
  String? deliveryDate;
  double? profit;

  Plant({
    required this.name,
    required this.cost,
    required this.price,
    required this.quantity,
    required this.imagePath,
    this.sellQuantity,
    this.buyer,
    this.deliveryDate,
    this.profit,
  });
  double calculateSellTotal() {
    final double priceValue = double.parse(price);
    final int sellQuantityValue = int.parse(sellQuantity ?? '');
    return priceValue * sellQuantityValue;
  }

  double calculateProfit() {
    final double priceValue = double.parse(price);
    final double costValue = double.parse(cost);
    final int quantityValue = int.parse(sellQuantity ?? '');
    return profit = (priceValue - costValue) * quantityValue;
  }

  bool isOutOfStock() {
    int currentQuantity = int.tryParse(quantity) ?? 0;
    return currentQuantity == 0;
  }
}
