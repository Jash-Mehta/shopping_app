import 'package:hive/hive.dart';

import 'package:shopping_app/models/cartmodel.dart';

class ProductData {
  ProductData(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.rating,
      required this.count});

  int id;
  String title;
  var price;
  String description;
  Category? category;
  String image;
  var rating;
  int count;
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

class Logindata {
  String email;
  String password;
  Logindata({
    required this.email,
    required this.password,
  });
}
