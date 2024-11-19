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

## Tugas 9 - PBP 24/25

Daniel Ferdiansyah, 2306275052

---

## Mengapa Perlu Membuat Model untuk JSON?

### 1. **Struktur Data yang Konsisten**
Model membantu memastikan struktur data JSON yang diterima atau dikirim selalu sesuai dengan spesifikasi yang diharapkan. Dengan model, kita bisa mendefinisikan properti apa saja yang diperlukan, tipe datanya, dan apakah properti tersebut opsional atau wajib. Hal ini meminimalkan kesalahan seperti data yang tidak lengkap atau tipe data yang salah.

### 2. **Validasi Otomatis**
Model memungkinkan validasi data secara otomatis sebelum digunakan di aplikasi. Misalnya, dalam framework seperti Django (dengan Django REST Framework), model dapat mendeteksi data yang tidak valid sebelum proses lebih lanjut dilakukan.

### 3. **Meningkatkan Pemeliharaan Kode**
Dengan model, kode menjadi lebih terstruktur dan mudah dipahami. Jika struktur data JSON berubah, kita cukup memperbarui modelnya tanpa perlu memeriksa setiap bagian kode yang menggunakan data tersebut.

### 4. **Mempermudah Serialisasi dan Deserialisasi**
Model mempermudah proses konversi antara objek Python dan JSON. Framework seperti Django atau FastAPI memiliki fitur bawaan untuk serialisasi (mengubah objek menjadi JSON) dan deserialisasi (mengubah JSON menjadi objek) jika menggunakan model.

---

### Apakah Akan Terjadi Error Jika Tidak Membuat Model?

Tidak membuat model tidak selalu menyebabkan error, tetapi bisa menimbulkan beberapa masalah, seperti:

1. **Kesalahan Data Tidak Teridentifikasi**  
   Tanpa model, Anda harus melakukan validasi data secara manual. Jika tidak, data yang tidak sesuai bisa masuk ke sistem, menyebabkan bug atau error di tahap berikutnya.

2. **Kode Menjadi Sulit Dikelola**  
   Tanpa model, setiap bagian kode yang berinteraksi dengan JSON harus memproses struktur data secara langsung, yang bisa menyebabkan redundansi kode dan membuatnya sulit untuk diubah atau diperbaiki.

3. **Kesulitan Debugging**  
   Jika terjadi kesalahan dalam struktur atau tipe data JSON, menemukan sumber masalah menjadi lebih sulit tanpa model.

---

## Fungsi Library `http` dalam Tugas Ini

### **1. Penghubung Antara Backend dan Frontend**
Library `http` berfungsi sebagai perantara antara aplikasi backend (Django) dan frontend (Flutter). Dalam kasus ini, library digunakan untuk melakukan *fetch data* atau berkomunikasi dengan API Django menggunakan metode seperti `POST` dan `GET`.

### **2. Implementasi Login dengan `POST` Request**
Kode berikut menunjukkan bagaimana library digunakan untuk mengirimkan data login (username dan password) ke endpoint Django untuk proses autentikasi:

```dart
final response = await request.login(
    "http://127.0.0.1:8000/auth/login/",
    {
        'username': username,
        'password': password,
    }
);
```
---
## Fungsi `CookieRequest` dan Pentingnya Membagikan Instance di Aplikasi Flutter

### **1. Fungsi `CookieRequest`**
`CookieRequest` adalah kelas yang mengelola permintaan HTTP sekaligus menangani sesi pengguna dengan cara menyimpan dan mengirimkan cookie secara otomatis. Ini sangat berguna terutama untuk aplikasi yang membutuhkan autentikasi berbasis sesi, seperti ketika menggunakan Django dengan middleware autentikasi.

Fungsi utama `CookieRequest` meliputi:
- **Manajemen Cookie**  
  `CookieRequest` menyimpan cookie yang diterima dari server (seperti `sessionid`) dan menggunakannya untuk setiap permintaan HTTP berikutnya, menjaga pengguna tetap masuk selama sesi berlangsung.
  
- **Mempermudah Login dan Logout**  
  `CookieRequest` biasanya memiliki metode khusus seperti `login` dan `logout` untuk menangani autentikasi pengguna.

- **Integrasi dengan REST API**  
  Menggunakan metode seperti `get` dan `post`, `CookieRequest` mempermudah komunikasi dengan API backend tanpa perlu mengelola header cookie secara manual.

#### Contoh:
```dart
final request = context.watch<CookieRequest>();
await request.login('http://127.0.0.1:8000/auth/login/', {
  'username': 'user123',
  'password': 'password123',
});
```
### **2. Mengapa Instance CookieRequest Perlu Dibagikan ke Seluruh Komponen?**
- **Mendukung Sesi yang Konsisten**
Semua komponen di aplikasi membutuhkan akses ke status sesi pengguna untuk menampilkan data yang relevan. Dengan membagikan instance `CookieRequest`, sesi dapat dikelola secara konsisten di seluruh aplikasi tanpa perlu membuat ulang instance di setiap halaman.

- **Mengelola Autentikasi Global**
Saat pengguna login atau logout, status autentikasi disimpan di `CookieRequest`. Membagikan instance memungkinkan komponen lain, seperti dashboard atau profile page, untuk memeriksa status autentikasi dan menyesuaikan UI (misalnya, menampilkan tombol login atau logout).

- **Efisiensi dan Pemeliharaan Kode**
Dengan satu instance `CookieRequest`, Anda menghindari duplikasi kode. Semua komponen yang membutuhkan data dari API backend cukup memanggil metode get atau post dari instance ini.

- **Mempermudah Pemantauan Status di Seluruh Aplikasi**
Jika menggunakan package seperti Provider untuk membagikan instance, setiap perubahan pada CookieRequest (seperti login atau logout) akan secara otomatis memberitahu komponen lain yang memantau perubahan tersebut.

---

## Mekanisme Pengiriman Data dari Input hingga Ditampilkan di Flutter

### 1. **Input Data**
Pengguna mengisi data produk melalui halaman `product_form.dart`. Form ini memungkinkan pengguna untuk memasukkan informasi produk, seperti nama, harga, dan deskripsi.

### 2. **Mengirim Request**
Setelah semua input terisi, pengguna menekan tombol submit. Data yang dimasukkan dikirim ke server Django menggunakan package `http` atau instance `CookieRequest`. Data tersebut dikirim dalam format JSON di bagian body dari request.

### 3. **Proses Backend**
- **Penerimaan Request**: Server Django menerima data melalui endpoint yang didefinisikan di `urls.py`.
- **Pemrosesan Data**: Logic untuk memproses data dijalankan di `views.py`. Data ini bisa disimpan ke database atau diolah sesuai kebutuhan aplikasi.
- **Mengembalikan Response**: Django mengembalikan respons ke Flutter dalam format JSON, yang berisi data hasil pemrosesan atau status request (misalnya, berhasil atau gagal).

### 4. **Menerima Response**
Aplikasi Flutter menerima respons JSON dari server Django. Respons ini dapat berisi data produk yang baru saja ditambahkan.

### 5. **Decode Data**
Respons JSON yang diterima diubah menjadi objek Dart menggunakan model yang sesuai. Proses ini memastikan data lebih mudah diakses dan digunakan di aplikasi Flutter.

### 6. **Menampilkan Data**
Data yang sudah dikonversi kemudian ditampilkan ke UI Flutter. Misalnya, data produk baru dapat ditampilkan dalam bentuk daftar di halaman utama aplikasi.

---

### **Summary**
1. Input data di Flutter → 
2. Kirim request ke Django (JSON) → 
3. Backend memproses dan menyimpan data → 
4. Backend mengirim response JSON → 
5. Respons diterima dan dikonversi menjadi objek Dart → 
6. Data ditampilkan di UI Flutter.


---

## Mekanisme Autentikasi: Login, Register, dan Logout

### 1. **Proses Login**
#### a. **Input Data**
Pengguna memasukkan email dan password di halaman login aplikasi Flutter.

#### b. **Mengirim Request**
Ketika tombol login diklik, data yang dimasukkan akan dikirim ke endpoint login di Django menggunakan `CookieRequest`. Data ini dikirim dalam format JSON.

#### c. **Proses di Backend**
- Django memeriksa kredensial (email dan password) yang diterima.
- Jika valid, Django mengembalikan cookie autentikasi yang menandakan sesi pengguna.

#### d. **Menyimpan Status**
Cookie autentikasi disimpan di `CookieRequest` untuk digunakan pada request berikutnya, seperti mengambil data pribadi atau melakukan transaksi.

#### e. **Tampilan Menu**
Setelah login berhasil, aplikasi Flutter akan menampilkan menu utama yang disesuaikan dengan status login pengguna. Misalnya, pengguna yang login dapat mengakses halaman dashboard.

### 2. **Proses Register**
#### a. **Input Data**
Pengguna mengisi informasi akun, seperti nama, email, dan password, melalui halaman register.

#### b. **Mengirim Request**
Ketika tombol register diklik, data tersebut dikirim ke endpoint register Django menggunakan `http` atau `CookieRequest`.

#### c. **Proses di Backend**
- Django menyimpan data pengguna baru ke database setelah memvalidasinya.
- Django mengembalikan respons sukses atau pesan error jika terjadi masalah (misalnya, email sudah terdaftar).

#### d. **Notifikasi**
Flutter menampilkan pesan sukses jika proses pendaftaran berhasil atau pesan error jika ada kendala. Setelah itu, pengguna diarahkan ke halaman login untuk masuk dengan akun baru.

### 3. **Proses Logout**
#### a. **Request Logout**
Pengguna menekan tombol logout, dan aplikasi Flutter mengirim request ke endpoint logout di Django menggunakan `CookieRequest`.

#### b. **Hapus Cookie**
Django menghapus session pengguna, sehingga cookie autentikasi menjadi tidak valid.

#### c. **Update Status**
Aplikasi Flutter memperbarui status pengguna menjadi tidak login. Hal ini dilakukan dengan menghapus data sesi dari instance `CookieRequest`.

#### d. **Navigasi**
Setelah logout, pengguna diarahkan kembali ke halaman login untuk masuk kembali jika diperlukan.

---

```markdown
## Langkah-langkah Implementasi Checklist

### **1. Mengimplementasikan Fitur Registrasi Akun**
#### a. **Membuat View Baru di Django**
Tambahkan view baru untuk menangani registrasi pengguna di file Django `views.py`:
```python
@csrf_exempt
def register(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data['username']
        password1 = data['password1']
        password2 = data['password2']
```

#### b. **Membuat Stateful Page**
Buat halaman baru di Flutter dengan stateful widget untuk formulir registrasi.

#### c. **Membuat Form Input**
Tambahkan input untuk username, password, dan konfirmasi password. Pastikan form ini menangani validasi input pengguna.

#### d. **Membuat Logic Tombol Registrasi**
Tambahkan tombol registrasi dengan logic pengiriman data ke backend:
```dart
final response = await request.postJson(
  "http://localhost:8000/auth/register/",
  jsonEncode({
    "username": username,
    "password1": password1,
    "password2": password2,
  }));
```

#### e. **Navigasi ke Halaman Login**
Setelah registrasi berhasil, arahkan pengguna ke halaman login:
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const LoginPage()),
);
```

---

### **2. Membuat Halaman Login**
#### a. **Membuat View Baru di Django**
Tambahkan view login di Django:
```python
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
```

#### b. **Membuat Stateful Page**
Buat halaman baru untuk login di Flutter dengan stateful widget.

#### c. **Membuat Form Input**
Tambahkan input untuk username dan password.

#### d. **Membuat Logic Tombol Login**
Tambahkan tombol login yang mengirimkan data ke Django:
```dart
ElevatedButton(
  onPressed: () async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final response = await request.login(
      "http://localhost:8000/auth/login/",
      {'username': username, 'password': password},
    );

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    }
  },
);
```

---

### **3. Mengintegrasikan Sistem Autentikasi Django dengan Flutter**
#### a. **Membuat View Login, Logout, dan Register**
Tambahkan semua endpoint autentikasi di Django.

#### b. **Memanggil Endpoint di Flutter**
Gunakan `http` atau `CookieRequest` untuk berinteraksi dengan endpoint Django.

#### c. **Memproses Output JSON**
Konversikan respons JSON dari Django menjadi model Dart yang sesuai.

#### d. **Membuat Model Kustom**
- Periksa data JSON dari endpoint (`localhost:8000/json`).
- Gunakan Quicktype untuk membuat model Dart.
- Simpan model di file `product_entry.dart`.

---

### **4. Menampilkan Daftar Item**
#### a. **Fetching JSON**
Buat fungsi untuk mengambil data JSON:
```dart
Future<List<ProductEntry>> fetchMood(CookieRequest request) async {
  final response = await request.get('http://localhost:8000/json/');

  var data = response;
  List<ProductEntry> listMood = [];
  for (var d in data) {
    if (d != null) {
      listMood.add(ProductEntry.fromJson(d));
    }
  }
  return listMood;
}
```

#### b. **Menggunakan FutureBuilder**
Gunakan `FutureBuilder` untuk menampilkan loader saat data sedang di-fetch:
```dart
body: FutureBuilder(
  future: fetchMood(request),
  builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      if (!snapshot.hasData) {
        return const Text('No data available');
      }
    }
  },
),
```

---

### **5. Membuat Halaman Detail Item**
#### a. **Membuat Stateful Page**
Tambahkan halaman detail untuk menampilkan informasi produk, seperti `uuid`, `name`, `description`, `price`, etc.

#### b. **Menyatakan Atribut**
Deklarasikan atribut yang diperlukan untuk halaman detail:
```dart
final String uuid;
final int name;
final String description;
final String price;
final String image;
final int quantity;

ProductDetailPage({
  required this.uuid,
  required this.name,
  required this.description,
  required this.price,
  required this.image,
  required this.quantity,
});
```

#### c. **Navigasi ke Halaman Detail**
Atur navigasi ke halaman detail saat produk di-klik:
```dart
child: InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          uuid: snapshot.data![index].pk.toString(),
          price: snapshot.data![index].fields.price,
          description: snapshot.data![index].fields.description,
          imageUrl: snapshot.data![index].fields.imageUrl,
        ),
      ),
    );
  },
),
```

#### d. **Menampilkan Detail**
Tampilkan data detail menggunakan atribut yang telah dideklarasikan:
```dart
SizedBox(height: 16.0),
Text(
  'Price: \$${widget.price}',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
Text(
  'Description: ${widget.description}',
  style: TextStyle(fontSize: 16),
),
```

---

### **6. Filter Item Berdasarkan User**
Tambahkan filter di view Django untuk hanya menampilkan produk milik pengguna yang sedang login:
```python
data = Product.objects.filter(user=request.user)
```
Dengan filter ini, hanya data relevan yang ditampilkan kepada user.
