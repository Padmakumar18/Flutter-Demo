import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/customer_form.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<dynamic> customers = [];

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    final data = await ApiService.getCustomers();
    setState(() {
      customers = data;
    });
  }

  Future<void> deleteCustomer(int id) async {
    await ApiService.deleteCustomer(id);
    fetchCustomers();
  }

  Future<void> showCustomerForm({Map<String, dynamic>? customer}) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomerForm(
            customer: customer,
            onSave: () {
              Navigator.pop(context);
              fetchCustomers();
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
      appBar: AppBar(title: const Text("Customers")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Address")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Age")),
            DataColumn(label: Text("Actions")),
          ],
          rows: customers
              .map(
                (customer) => DataRow(
                  cells: [
                    DataCell(Text(customer['id'].toString())),
                    DataCell(Text(customer['customer_name'] ?? '')),
                    DataCell(Text(customer['phone_number'] ?? '')),
                    DataCell(Text(customer['address'] ?? '')),
                    DataCell(Text(customer['email_address'] ?? '')),
                    DataCell(Text(customer['age'].toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                showCustomerForm(customer: customer),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteCustomer(customer['id']),
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
        onPressed: () => showCustomerForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
