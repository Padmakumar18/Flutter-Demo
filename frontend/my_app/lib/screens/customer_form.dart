import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CustomerForm extends StatefulWidget {
  final Map<String, dynamic>? customer;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CustomerForm({
    super.key,
    this.customer,
    required this.onSave,
    required this.onCancel,
  });

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.customer?['customer_name'] ?? '',
    );
    phoneController = TextEditingController(
      text: widget.customer?['phone_number'] ?? '',
    );
    addressController = TextEditingController(
      text: widget.customer?['address'] ?? '',
    );
    emailController = TextEditingController(
      text: widget.customer?['email_address'] ?? '',
    );
    ageController = TextEditingController(
      text: widget.customer?['age']?.toString() ?? '',
    );
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      final customer = {
        "customer_name": nameController.text,
        "phone_number": phoneController.text,
        "address": addressController.text,
        "email_address": emailController.text,
        "age": int.parse(ageController.text),
      };
      await ApiService.saveCustomer(customer, id: widget.customer?['id']);
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
              widget.customer != null ? "Edit Customer" : "Add Customer",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
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
