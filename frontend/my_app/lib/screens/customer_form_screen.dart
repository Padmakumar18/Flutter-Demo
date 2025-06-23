// Directory: frontend/lib/widgets/customer_form.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CustomerForm extends StatefulWidget {
  final Map<String, dynamic>? customer;

  const CustomerForm({super.key, this.customer});

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

  void saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final customer = {
        "customer_name": nameController.text,
        "phone_number": phoneController.text,
        "address": addressController.text,
        "email_address": emailController.text,
        "age": int.parse(ageController.text),
      };
      await ApiService.saveCustomer(customer, id: widget.customer?['id']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer != null ? "Edit Customer" : "Add Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: saveCustomer, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
