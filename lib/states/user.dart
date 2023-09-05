import 'package:customer_app/data/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState {
  final int id;
  final String name;
  final String email;
  final Gender gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String token;

  UserState({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.token,
  });

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: parseGender(json['gender']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] == Null ? DateTime.parse(json['deletedAt']) : null,
      token: json['token'],
    );
  }

}

class UserProvider with ChangeNotifier {
  UserState? _user;

  UserState? get user => _user;

  void setUser(UserState user) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }
}

UserProvider readUserProvider(BuildContext context) {
  UserProvider userProvider = context.read<UserProvider>();

  return userProvider;
}

UserState? getUserState(BuildContext context) {
  UserProvider userProvider = readUserProvider(context);

  return userProvider.user;
}

UserState? watchUserState(BuildContext context) {
  return context.watch<UserProvider>().user;
}
