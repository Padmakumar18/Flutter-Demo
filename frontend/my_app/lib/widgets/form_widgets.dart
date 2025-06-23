// Directory: frontend/lib/widgets/form_widgets.dart
import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    ),
  );
}

Widget submitButton({required VoidCallback onPressed, required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: ElevatedButton(onPressed: onPressed, child: Text(text)),
  );
}

// Example usage:
// customTextField(controller: myController, label: "Name"),
// submitButton(onPressed: () => save(), text: "Save")
