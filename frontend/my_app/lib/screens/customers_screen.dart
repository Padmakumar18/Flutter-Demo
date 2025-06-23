// Directory: frontend/lib/screens/customers_screen.dart
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customers")),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            title: Text(customer['customer_name'] ?? ''),
            subtitle: Text(customer['email_address'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerForm(customer: customer),
                      ),
                    );
                    fetchCustomers();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteCustomer(customer['id']),
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
            MaterialPageRoute(builder: (_) => CustomerForm()),
          );
          fetchCustomers();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
