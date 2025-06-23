// Directory: frontend/lib/screens/products_screen.dart
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['food_name'] ?? ''),
            subtitle: Text("₹ ${product['price'].toString()}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductForm(product: product),
                      ),
                    );
                    fetchProducts();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteProduct(product['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductForm()),
          );
          fetchProducts();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
