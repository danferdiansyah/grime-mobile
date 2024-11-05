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

## Tugas 7 - PBP 24/25

## Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.

Dalam framework Flutter, terdapat dua jenis widget utama: `StatelessWidget` dan `StatefulWidget`. 

- **StatelessWidget**: Widget ini bersifat statis dan tidak memiliki state yang bisa berubah secara *lifetime*. Artinya, setelah widget ini dibuat, isinya tidak akan berubah. Stateless widget cocok digunakan untuk elemen-elemen UI yang sifatnya tetap, seperti teks atau *icon* yang tidak perlu di-update.

  Contoh stateless widget:
  ```dart
  class MyTextWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Text('Hello, World!');
    }
  }
  ```

- **StatefulWidget**: Sebaliknya, widget ini memiliki state yang dapat berubah seiring waktu. Misalnya, sebuah tombol yang jika ditekan akan mengubah teks yang ditampilkan, atau sebuah counter yang melakukan *increment* setiap kali tombol ditekan. Dengan kata lain, jika ada elemen UI yang bergantung pada interaksi pengguna atau perubahan data, maka kita akan menggunakan `StatefulWidget`.

  Contoh stateful widget:
  ```dart
  class MyCounterWidget extends StatefulWidget {
    @override
    _MyCounterWidgetState createState() => _MyCounterWidgetState();
  }

  class _MyCounterWidgetState extends State<MyCounterWidget> {
    int _counter = 0;

    void _incrementCounter() {
      setState(() {
        _counter++;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Text('Counter: $_counter'),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment'),
          ),
        ],
      );
    }
  }
  ```

**Perbedaan utama** antara keduanya terletak pada kemampuannya untuk menyimpan dan mengubah state. Stateless widget tidak bisa diubah isinya setelah dibuat, sementara stateful widget bisa diperbarui sesuai dengan perubahan state yang terjadi.

---

## Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.

Widget yang digunakan pada proyek ini meliputi:

1. **Scaffold**  
   Scaffold menyediakan struktur dasar halaman, seperti `appBar`, `body`, dan `floatingActionButton`. Di sini, Scaffold digunakan untuk menyediakan struktur halaman utama dengan app bar dan body yang diisi dengan komponen lainnya.

2. **AppBar**  
   AppBar menampilkan bar di bagian atas halaman dengan judul. Pada proyek ini, `AppBar` digunakan untuk menampilkan teks "grime" sebagai judul, dengan style yang ditentukan.

3. **Padding**  
   Widget Padding menambahkan ruang kosong di sekitar widget yang ditempatkan di dalamnya. Pada proyek ini, Padding digunakan untuk memberi jarak di sekitar elemen-elemen di dalam `body` Scaffold dan elemen lain yang ada di dalam `Column`.

4. **Column dan Row**  
   `Column` menampilkan child widget secara vertikal, sementara `Row` menampilkan secara horizontal. Dalam proyek ini, `Row` digunakan untuk menampilkan beberapa `InfoCard` dalam satu baris, sedangkan `Column` digunakan untuk menata widget secara vertikal di `body`.

5. **InfoCard**  
   InfoCard adalah widget kustom yang dibuat dari `StatelessWidget`. Widget ini menampilkan informasi berupa judul dan konten (seperti NPM, nama, dan kelas), dan dikemas menggunakan `Card` yang memberikan efek elevasi.

6. **Card**  
   Widget Card memberikan tampilan berbentuk kartu dengan elevasi. Pada `InfoCard`, Card digunakan untuk *wrapping* informasi agar terlihat lebih menonjol dan terorganisir.

7. **Text**  
   Text digunakan untuk menampilkan teks di layar. Dalam proyek ini, Text digunakan di beberapa tempat untuk menampilkan judul, konten, dan label tombol.

8. **GridView.count**  
   `GridView.count` adalah jenis GridView yang memungkinkan kita menentukan jumlah kolom tetap (seperti `crossAxisCount: 3`). Widget ini digunakan untuk menampilkan daftar `ItemCard` dalam layout grid yang fleksibel.

9. **ItemCard**  
   ItemCard adalah widget kustom yang menampilkan informasi dan icon. Widget ini menggunakan `Material` dan `InkWell` untuk memberikan efek tap yang interaktif.

10. **Material**  
    Material adalah widget dasar untuk memberikan tampilan material design pada widget. Di sini, `Material` digunakan pada `ItemCard` untuk menyediakan tampilan material design.

11. **InkWell**  
    InkWell adalah widget yang memungkinkan kita untuk menambahkan efek "ripple" saat widget ditekan. Dalam `ItemCard`, InkWell digunakan agar setiap item di dalam grid menjadi interaktif ketika ditekan.

12. **Icon**  
    Icon digunakan untuk menampilkan *icon* pada UI. Dalam proyek ini, Icon digunakan pada `ItemCard` untuk menampilkan *icon* yang sesuai dengan masing-masing item.

13. **SizedBox**  
    `SizedBox` menyediakan ruang kosong dengan ukuran tertentu. Pada proyek ini, `SizedBox` digunakan untuk memberi jarak vertikal antara elemen, seperti antara teks dan *icon* di `ItemCard`.

14. **ScaffoldMessenger**  
    `ScaffoldMessenger` memungkinkan untuk menampilkan pesan sementara menggunakan `SnackBar`. Pada proyek ini, `ScaffoldMessenger` digunakan untuk menampilkan notifikasi ketika `ItemCard` ditekan.

15. **SnackBar**  
    SnackBar adalah notifikasi singkat yang muncul di bagian bawah layar. Dalam proyek ini, `SnackBar` digunakan di `ItemCard` untuk memberi pesan bahwa tombol telah ditekan, menampilkan nama item yang ditekan.

Widget-widget tersebut bekerja sama untuk membentuk *interface* aplikasi yang menarik dan interaktif, dengan fungsi dasar tampilan dan beberapa interaksi dasar saat pengguna menekan item.

---

## Apa fungsi dari `setState()`? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.

Fungsi `setState()` digunakan dalam stateful widget untuk memberi tahu Flutter bahwa ada perubahan pada state yang perlu direfleksikan pada UI. Ketika `setState()` dipanggil, Flutter akan merender ulang widget sehingga perubahan yang dilakukan dapat ditampilkan. Pada project ini, tidak digunakan `setState()`, akan tetapi jika setState() diterapkan, variabel-variabel yang dapat terdampak mencakup data-data yang mungkin mengalami perubahan selama aplikasi berjalan. Beberapa contoh di antaranya adalah:

`npm`, `name`, dan `className`: Variabel-variabel ini saat ini bersifat final dan statis, tetapi jika  perlu diubah, `setState()` bisa digunakan untuk memperbarui tampilan agar mencerminkan nilai terbaru dari masing-masing variabel. Misalnya, jika data profil pengguna dapat diperbarui, maka perubahan tersebut bisa di-refleksikan dengan memanggil `setState()`.

`items`: Daftar item pada halaman utama yang mencakup item seperti "Lihat Daftar Produk", "Tambah Produk", dan "Logout". Jika daftar ini diperluas, dikurangi, atau elemen-elemennya dimodifikasi (misalnya, menambahkan item baru atau mengganti icon), `setState()` bisa dipakai untuk merender ulang tampilan dan menampilkan perubahan pada GridView.

Properti dalam `ItemCard`: Jika setiap kartu item (ItemCard) membutuhkan perubahan dinamis, misalnya warna background atau ikon yang berubah berdasarkan kondisi tertentu, `setState()` dapat digunakan untuk memperbarui tampilan kartu ini. Hal ini akan berguna jika, misalnya, ada perubahan status atau aksi tertentu yang mempengaruhi tampilan masing-masing `ItemCard`.

---

## Jelaskan perbedaan antara const dengan final.

`const` dan `final` digunakan untuk mendeklarasikan variabel yang bersifat immutable (tidak dapat diubah). Namun, terdapat perbedaan utama:

- **const**: Nilai variabel ini harus diketahui pada saat compile-time. Biasanya digunakan untuk nilai konstan yang diketahui sebelum runtime.
  
  ```dart
  const pi = 3.14;
  ```

- **final**: Nilai variabel ini hanya dapat diinisialisasi sekali, tetapi nilainya bisa didapatkan saat runtime. `final` sering digunakan ketika nilai variabel didapatkan dari proses yang berjalan saat aplikasi berjalan.
  
  ```dart
  final now = DateTime.now();
  ```

Dapat disimpulkan bahwa `const` digunakan jika nilainya diketahui sebelum runtime, dan `final` digunakan jika nilainya baru akan ditentukan pada saat runtime.
