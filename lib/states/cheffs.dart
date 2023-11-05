import 'package:customer_app/data/types.dart';

class CheffState {
  final int id;
  final String name;
  final String email;
  final Gender gender;
  final String mainCuisine;
  final String city;
  final String registerStatus;
  final String registerReason;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  List<FoodPlate>? foodPlates;

  CheffState({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.mainCuisine,
    required this.city,
    required this.registerStatus,
    required this.registerReason,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory CheffState.fromJson(Map<String, dynamic> json) {
    return CheffState(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: parseGender(json['gender']),
      mainCuisine: json['mainCuisine'],
      city: json['city'],
      registerStatus: json['registerStatus'],
      registerReason: json['registerReason'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == Null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] == Null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}

class FoodPlate {
  final int id;
  final int cheffId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int minServe;
  final int maxServe;
  final double cookTime;
  final bool glutenFree;
  final bool lactoseFree;
  final bool vegan;
  final bool vegetarian;
  final bool light;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  FoodPlate({
    required this.id,
    required this.cheffId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.minServe,
    required this.maxServe,
    required this.cookTime,
    required this.glutenFree,
    required this.lactoseFree,
    required this.vegan,
    required this.vegetarian,
    required this.light,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory FoodPlate.fromJson(Map<String, dynamic> json) {
    return FoodPlate(
      id: json['id'],
      cheffId: json['cheffId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: double.tryParse(json['price'].toString())!,
      minServe: json['minServe'],
      maxServe: json['maxServe'],
      cookTime: double.tryParse(json['cookTime'].toString())!,
      glutenFree: json['glutenFree'],
      lactoseFree: json['lactoseFree'],
      vegan: json['vegan'],
      vegetarian: json['vegetarian'],
      light: json['light'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == Null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] == Null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
