import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<List<dynamic>> getCustomers() async {
    final response = await http.get(Uri.parse("$baseUrl/customers"));
    print("GET Customers -> ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load customers");
    }
  }

  static Future<void> deleteCustomer(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/customers/$id"));
    print("DELETE Customer -> ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception("Failed to delete customer");
    }
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
    print("SAVE Customer -> ${response.statusCode}");
    print(response.body);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save customer");
    }
  }

  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));
    print("GET Products -> ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/products/$id"));
    print("DELETE Product -> ${response.statusCode}");
    if (response.statusCode != 200) throw Exception("Failed to delete product");
  }

  static Future<void> saveProduct(
    Map<String, dynamic> product, {
    int? id,
  }) async {
    final url = id != null ? "$baseUrl/products/$id" : "$baseUrl/products";
    if (product.containsKey("date") && product["date"] is DateTime) {
      product["date"] = (product["date"] as DateTime)
          .toIso8601String()
          .substring(0, 10);
    }

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
    print("SAVE Product -> ${response.statusCode}");
    print(response.body);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save product");
    }
  }
}
