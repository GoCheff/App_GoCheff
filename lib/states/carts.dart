import 'package:customer_app/states/cheffs.dart';

class CartState {
  final int id;
  final int customerId;
  final String status;
  final String locale;
  final String eventDate;
  final String phoneContact;
  final String observation;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  List<CartItem>? cartItems;

  CartState(
      {required this.id,
      required this.customerId,
      required this.status,
      required this.locale,
      required this.eventDate,
      required this.phoneContact,
      required this.observation,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      this.cartItems});

  factory CartState.fromJson(Map<String, dynamic> json) {
    return CartState(
      id: json['id'],
      customerId: json['customerId'],
      status: json['status'],
      locale: json['locale'],
      eventDate: json['eventDate'],
      phoneContact: json['phoneContact'],
      observation: json['observation'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == Null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] == Null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}

class CartItem {
  final int id;
  final int cartId;
  final int foodPlateId;
  final int quantity;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  final FoodPlate? foodPlate;

  CartItem({
    required this.id,
    required this.cartId,
    required this.foodPlateId,
    required this.quantity,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.foodPlate,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cartId'],
      foodPlateId: json['foodPlateId'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == Null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] == Null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
