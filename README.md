# grime

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## Tugas 8 - PBP 24/25

Daniel Ferdiansyah, 2306275052

---

## Apa kegunaan `const` di Flutter? Jelaskan apa keuntungan ketika menggunakan `const` pada kode Flutter. Kapan sebaiknya kita menggunakan `const`, dan kapan sebaiknya tidak digunakan?

Di Flutter, `const` digunakan untuk mendeklarasikan nilai atau widget yang **immutable** dan **constant pada compile-time**. Keuntungannya adalah:

1. **Penghematan Memori**: Widget `const` hanya dibuat sekali dan tidak perlu di-render ulang, mengurangi penggunaan memori.
2. **Optimisasi Kinerja**: `const` menghindari pembuatan objek baru pada setiap rebuild sehingga mempercepat aplikasi.
3. **Keamanan pada Compile-Time**: `const` memastikan bahwa nilai tidak berubah, sehingga potensi error bisa dideteksi saat kompilasi.

### Kapan Menggunakan `const`
Gunakan `const` untuk widget atau data yang **tidak akan berubah** selama runtime, seperti `Text` atau `Icon` yang statis:

```dart
const Text('Hello, Flutter!');
const Icon(Icons.star);
```

### Kapan Tidak Menggunakan `const`
Hindari `const` pada widget yang bergantung pada **state yang dinamis** atau data yang berubah, seperti input pengguna atau data dari backend:

```dart
Text(dynamicText); // Tidak menggunakan const karena nilainya dinamis
```

Dengan `const`, aplikasi bisa lebih efisien, tetapi gunakan hanya untuk elemen statis agar tetap fleksibel.

---
## Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!
Di Flutter, `Column` dan `Row` adalah widget layout yang digunakan untuk menata widget secara vertikal dan horizontal.

- **Column**: Menata widget secara vertikal (dari atas ke bawah). Widget ini cocok digunakan untuk membuat tampilan yang berurutan secara vertikal seperti teks di bawah gambar atau tombol di bawah input.
- **Row**: Menata widget secara horizontal (dari kiri ke kanan). Biasanya digunakan untuk menempatkan beberapa elemen di samping satu sama lain, seperti ikon dengan teks atau deretan tombol.

### Contoh Penggunaan `Column` dan `Row`

Pada contoh berikut, `Column` digunakan untuk menata widget secara vertikal di dalam `Scaffold`, sementara `Row` digunakan untuk menata beberapa `InfoCard` secara horizontal.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'grime',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    drawer: const LeftDrawer(),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Menggunakan Row untuk menata InfoCard secara horizontal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoCard(title: 'NPM', content: npm),
              InfoCard(title: 'Name', content: name),
              InfoCard(title: 'Class', content: className),
            ],
          ),
          const SizedBox(height: 16.0),
          
          // Welcome Message dan Grid Item dalam Column
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Welcome to grime.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                GridView.count(
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((ItemHomepage item) {
                    return ItemCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
```

### Penjelasan Contoh
- `Column`: Mengatur tampilan `Row` dari `InfoCard`, pesan selamat datang, dan `GridView`.
- `Row`: Menyusun beberapa `InfoCard` secara horizontal dengan jarak yang merata (`mainAxisAlignment: MainAxisAlignment.spaceEvenly`).

---
## Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!

Pada product form **Grime**, beberapa elemen input yang saya gunakan adalah:

1. **TextFormField**: digunakan untuk memasukkan teks dari pengguna.
   - Field untuk **Product Name** (`_name`), menerima teks biasa.
   - Field untuk **Product Amount** (`_amount`), diharapkan menerima angka.
   - Field untuk **Product Description** (`_description`), menerima teks deskripsi produk.

2. **ElevatedButton**: digunakan sebagai tombol untuk menyimpan data. Tombol ini men-*trigger* validasi form dan menampilkan dialog konfirmasi.

### Elemen Input Lain yang Tidak Digunakan
Beberapa elemen input Flutter lainnya yang tidak digunakan di form **Grime**, antara lain:

- **Checkbox**: digunakan untuk memilih opsi true/false. Cocok jika ada kondisi yang perlu dicek.
- **Radio**: digunakan untuk memilih salah satu dari beberapa pilihan. Misalnya, kategori produk.
- **Switch**: widget toggle untuk opsi on/off.
- **DropdownButton**: digunakan untuk memilih dari daftar opsi yang tersedia.
- **Slider**: widget untuk memilih nilai dalam rentang tertentu, misalnya untuk menentukan harga.
- **DatePicker**: untuk memilih tanggal tertentu, cocok jika data produk memerlukan tanggal produksi atau tanggal kadaluarsa.
Elemen-elemen tersebut belum terlalu dibutuhkan untuk saat ini, sehingga tidak digunakan pada form **Grime**.
---

##  Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?

Untuk menjaga konsistensi tema dalam aplikasi Flutter, saya menggunakan properti `ThemeData` pada file `main.dart` untuk mendefinisikan elemen-elemen tema secara global. Dengan ini, seluruh halaman dan widget dalam aplikasi akan memiliki tampilan yang seragam tanpa harus mengatur warna dan gaya secara terpisah di setiap widget.

Berikut adalah implementasi dari `main.dart` saya:

```dart
import 'package:flutter/material.dart';
import 'package:grime/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF05e500), // Main green color
          primary: const Color(0xFF05e500),
          secondary: const Color(0xFF05e500),
          background: const Color(0xFF0c0c0c), // Main black background
        ),
        scaffoldBackgroundColor: const Color(0xFF0c0c0c), 
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

```

Pada kode di atas, saya telah menerapkan `ThemeData` dengan konfigurasi berikut:
1. **ColorScheme**: Menggunakan `ColorScheme.fromSeed` untuk mendefinisikan warna `primary`, warna `secondary`, dan warna `background` agar tampilan aplikasi konsisten.
   - `primary` dan `secondary` diatur ke hijau (`0xFF05e500`), yang menjadi warna utama di seluruh aplikasi.
   - `background` dan `scaffoldBackgroundColor` diatur ke warna hitam (`0xFF0c0c0c`) sebagai `background` utama.

2. **useMaterial3**: Diset ke `true` untuk menggunakan Material Design 3

Dengan konfigurasi ini, warna-warna yang telah didefinisikan akan diterapkan ke komponen yang menggunakan warna tema, seperti `AppBar`, `Button`, `Dialog`, dan lain-lain.

---

## Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?
**Grime** mengimplementasikan navigasi menggunakan drawer atau panel samping `LeftDrawer`, yang memudahkan akses ke berbagai halaman.

### Implementasi Navigasi
`Navigator` digunakan sebagai pengelola utama navigasi dalam Flutter. Dalam `LeftDrawer`, setiap item menu menggunakan metode `Navigator.push` atau `Navigator.pushReplacement`. 

1. **Navigator.pushReplacement**: Saat pengguna memilih menu "Home," digunakan `Navigator.pushReplacement` yang berguna untuk menggantikan halaman saat ini dengan halaman baru tanpa menyimpan halaman sebelumnya dalam stack, sehingga ketika pengguna menekan tombol "Back," mereka tidak kembali ke halaman yang diganti.
   
2. **Navigator.push**: Untuk halaman "Add Product," saya menggunakan `Navigator.push`, yang menambahkan halaman baru ke atas stack navigasi, memungkinkan pengguna kembali ke halaman sebelumnya dengan menekan tombol "Back."

Dengan approach navigasi ini, saya memastikan bahwa perpindahan antar halaman terasa natural dan intuitif. Penggunaan `Navigator.pushReplacement` pada menu utama menjaga stack tetap rapi, sementara `Navigator.push` memungkinkan pengguna untuk kembali ke halaman sebelumnya tanpa kehilangan data.

---

