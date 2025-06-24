import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductForm extends StatefulWidget {
  final Map<String, dynamic>? product;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProductForm({
    super.key,
    this.product,
    required this.onSave,
    required this.onCancel,
  });

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
    dateController = TextEditingController(
      text: widget.product?['date']?.toString() ?? '',
    );
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      final product = {
        "food_name": nameController.text,
        "price": double.parse(priceController.text),
        "quantity": int.parse(quantityController.text),
        "date": dateController.text,
      };
      await ApiService.saveProduct(product, id: widget.product?['id']);
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.product != null ? "Edit Product" : "Add Product",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Food Name"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date (YYYY-MM-DD)"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text("Cancel"),
                ),
                ElevatedButton(onPressed: save, child: const Text("Save")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
