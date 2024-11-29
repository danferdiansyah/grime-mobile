import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final int quantity;
  final String? imageUrl; 
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    this.imageUrl,
  });


  factory Product.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'];
    const String mediaBaseUrl = 'http://127.0.0.1:8000/media/'; 
    return Product(
      id: json['pk'],
      name: fields['name'],
      price: fields['price'],
      description: fields['description'],
      quantity: fields['quantity'],
      imageUrl: fields['image'] != null ? mediaBaseUrl + fields['image'] : null, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "model": "main.product",
      "pk": id,
      "fields": {
        "name": name,
        "price": price,
        "description": description,
        "quantity": quantity,
        "image": imageUrl?.replaceFirst('http://127.0.0.1:8000/media/', ''), 
      },
    };
  }

  bool get isPriceValid => price > 0;
}
