import 'package:customer_app/data/types.dart';
import 'package:customer_app/states/cheffs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState {
  final int id;
  final String name;
  final String email;
  final Gender gender;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  final String token;

  List<CheffState>? cheffs;

  List<String>? possibleMainCuisines;

  String? mainCuisine;
  String? city;
  bool? glutenFree;
  bool? lactoseFree;
  bool? vegan;
  bool? vegetarian;
  bool? light;

  UserState(
      {required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.token,
      this.cheffs,
      this.possibleMainCuisines,
      this.mainCuisine,
      this.city,
      this.glutenFree,
      this.lactoseFree,
      this.vegan,
      this.vegetarian,
      this.light});

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        gender: parseGender(json['gender']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] == Null
            ? DateTime.parse(json['updatedAt'])
            : null,
        deletedAt: json['deletedAt'] == Null
            ? DateTime.parse(json['deletedAt'])
            : null,
        token: json['token'],
        cheffs: null,
        possibleMainCuisines: null,
        mainCuisine: null,
        city: null,
        glutenFree: null,
        lactoseFree: null,
        vegan: null,
        vegetarian: null,
        light: null);
  }
}

class UserProvider with ChangeNotifier {
  UserState? _user;

  UserState? get user => _user;

  void setUser(UserState user) {
    _user = user;
    notifyListeners();
  }

  void setCheffs(List<CheffState> cheffs) {
    if (_user == null) return;

    _user!.cheffs = cheffs;
    notifyListeners();
  }

  void setCheffFoodPlate(int cheffId, List<FoodPlate> foodPlates) {
    if (_user == null) return;

    _user!.cheffs!.firstWhere((element) => element.id == cheffId).foodPlates =
        foodPlates;
    notifyListeners();
  }

  void setPossibleMainCuisines(List<String> cuisines) {
    if (_user == null) return;

    _user!.possibleMainCuisines = cuisines;
    notifyListeners();
  }

  void setMainCuisine(String? mainCuisine) {
    if (_user == null) return;

    _user!.mainCuisine = mainCuisine;
    notifyListeners();
  }

  void setCity(String city) {
    if (_user == null) return;

    _user!.city = city;
    notifyListeners();
  }

  void setGlutenFree(bool glutenFree) {
    if (_user == null) return;

    _user!.glutenFree = glutenFree;
    notifyListeners();
  }

  void setLactoseFree(bool lactoseFree) {
    if (_user == null) return;

    _user!.lactoseFree = lactoseFree;
    notifyListeners();
  }

  void setVegan(bool vegan) {
    if (_user == null) return;

    _user!.vegan = vegan;
    notifyListeners();
  }

  void setVegetarian(bool vegetarian) {
    if (_user == null) return;

    _user!.vegetarian = vegetarian;
    notifyListeners();
  }

  void setLight(bool light) {
    if (_user == null) return;

    _user!.light = light;
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
