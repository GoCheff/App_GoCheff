import 'package:customer_app/data/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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