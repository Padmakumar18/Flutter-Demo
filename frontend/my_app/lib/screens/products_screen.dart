import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/product_form.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final data = await ApiService.getProducts();
    setState(() {
      products = data;
    });
  }

  Future<void> deleteProduct(int id) async {
    await ApiService.deleteProduct(id);
    fetchProducts();
  }

  Future<void> showProductForm({Map<String, dynamic>? product}) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ProductForm(
            product: product,
            onSave: () {
              Navigator.pop(context);
              fetchProducts();
            },
            onCancel: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Price")),
            DataColumn(label: Text("Quantity")),
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Actions")),
          ],
          rows: products
              .map(
                (product) => DataRow(
                  cells: [
                    DataCell(Text(product['id'].toString())),
                    DataCell(Text(product['food_name'] ?? '')),
                    DataCell(Text(product['price'].toString())),
                    DataCell(Text(product['quantity'].toString())),
                    DataCell(Text(product['date'].toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => showProductForm(product: product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteProduct(product['id']),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showProductForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
