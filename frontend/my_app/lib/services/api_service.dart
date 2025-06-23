// Directory: frontend/lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<List<dynamic>> getCustomers() async {
    final response = await http.get(Uri.parse("$baseUrl/customers"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load customers");
    }
  }

  static Future<void> deleteCustomer(int id) async {
    await http.delete(Uri.parse("$baseUrl/customers/$id"));
  }

  static Future<void> saveCustomer(
    Map<String, dynamic> customer, {
    int? id,
  }) async {
    final url = id != null ? "$baseUrl/customers/$id" : "$baseUrl/customers";
    final response = await (id != null
        ? http.put(
            Uri.parse(url),
            body: jsonEncode(customer),
            headers: {"Content-Type": "application/json"},
          )
        : http.post(
            Uri.parse(url),
            body: jsonEncode(customer),
            headers: {"Content-Type": "application/json"},
          ));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save customer");
    }
  }

  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<void> deleteProduct(int id) async {
    await http.delete(Uri.parse("$baseUrl/products/$id"));
  }

  static Future<void> saveProduct(
    Map<String, dynamic> product, {
    int? id,
  }) async {
    final url = id != null ? "$baseUrl/products/$id" : "$baseUrl/products";
    final response = await (id != null
        ? http.put(
            Uri.parse(url),
            body: jsonEncode(product),
            headers: {"Content-Type": "application/json"},
          )
        : http.post(
            Uri.parse(url),
            body: jsonEncode(product),
            headers: {"Content-Type": "application/json"},
          ));
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save product");
    }
  }
}
