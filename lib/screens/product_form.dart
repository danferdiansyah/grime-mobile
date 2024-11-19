import 'package:flutter/material.dart';
import 'package:grime/widgets/left_drawer.dart';
import 'package:grime/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  int _quantity = 0;
  String _image = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add New Product',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Name",
                hint: "Product Name",
                onChanged: (value) => setState(() => _name = value),
                validator: (value) => value == null || value.isEmpty
                    ? "Product name cannot be empty!"
                    : null,
              ),
              _buildNumberField(
                label: "Price",
                hint: "Product Price",
                onChanged: (value) => setState(() => _price = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product price cannot be empty!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Product price must be a number!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Description",
                hint: "Product Description",
                onChanged: (value) => setState(() => _description = value),
                validator: (value) => value == null || value.isEmpty
                    ? "Product description cannot be empty!"
                    : null,
              ),
              _buildNumberField(
                label: "Quantity",
                hint: "Product Quantity",
                onChanged: (value) => setState(() => _quantity = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product quantity cannot be empty!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Product quantity must be a number!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Image URL",
                hint: "Image Link",
                onChanged: (value) => setState(() => _image = value),
                validator: (value) => value == null || value.isEmpty
                    ? "Image URL cannot be empty!"
                    : null,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim data ke server Django dan tunggu respons
                        final response = await request.postJson(
                          "http://localhost:8000/create-product-flutter/",
                          jsonEncode(<String, dynamic>{
                            'name': _name,
                            'price': _price.toString(),
                            'description': _description,
                            'quantity': _quantity.toString(),
                            'image': _image,
                          }),
                        );

                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Product baru berhasil disimpan!"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Terdapat kesalahan, silakan coba lagi."),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
