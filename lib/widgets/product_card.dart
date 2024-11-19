import 'package:flutter/material.dart';
import 'package:grime/screens/product_form.dart';
import 'package:grime/screens/list_product.dart';

class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (item.name == "Tambah Produk") {
      backgroundColor = Colors.white;
      textColor = Colors.black;
    } else if (item.name == "Logout") {
      backgroundColor = Colors.red;
      textColor = Colors.white;
    } else {
      backgroundColor = Theme.of(context).colorScheme.secondary;
      textColor = Colors.white;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (item.name == "Tambah Produk") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          } else if (item.name == "Lihat Daftar Produk") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductPage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: textColor,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
