class CartItemModel {
  final int? id;
  final int productId;
  final int quantity;
  final String? productName;
  final double? productPrice;

  CartItemModel({
    this.id,
    required this.productId,
    required this.quantity,
    this.productName,
    this.productPrice,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      productId: map['productId'],
      quantity: map['quantity'],
      productName: map['name'],
      productPrice: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
    };
  }
}