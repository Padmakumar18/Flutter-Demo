// Directory: frontend/lib/widgets/product_form.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductForm extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductForm({super.key, this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.product?['food_name'] ?? '',
    );
    priceController = TextEditingController(
      text: widget.product?['price']?.toString() ?? '',
    );
    quantityController = TextEditingController(
      text: widget.product?['quantity']?.toString() ?? '',
    );
    dateController = TextEditingController(text: widget.product?['date'] ?? '');
  }

  void saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = {
        "food_name": nameController.text,
        "price": double.parse(priceController.text),
        "quantity": int.parse(quantityController.text),
        "date": dateController.text,
      };
      await ApiService.saveProduct(product, id: widget.product?['id']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? "Edit Product" : "Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Food Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(labelText: "Date (YYYY-MM-DD)"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: saveProduct, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
