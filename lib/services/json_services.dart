import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/Product.dart';

class JsonService {
  static Future<List<Product>> loadProducts() async {
    final String jsonString = await rootBundle.loadString(
      'assets/products.json',
    );

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((item) => Product.fromJson(item)).toList();
  }
}
