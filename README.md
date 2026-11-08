# ToDo List App (Flutter)

Aplikasi manajemen tugas (To-Do List) sederhana, bersih, dan responsif yang dibangun menggunakan framework **Flutter**. Aplikasi ini dapat dijalankan langsung di lingkungan lokal (Mobile/Web/Desktop) atau di-deploy ke dalam kontainer **Docker** berbasis **Nginx**.

---

## 🚀 Fitur Utama

- **Pencarian Real-time**: Cari tugas yang ada berdasarkan kata kunci secara langsung.
- **Daftar Tugas Dinamis**: Tandai tugas sebagai selesai (*completed*) dengan efek coret teks atau batalkan status selesai.
- **Tambah & Hapus Tugas**: Tambahkan tugas baru melalui bilah input di bagian bawah dan hapus tugas dengan satu klik.
- **Multiplatform & Dockerized**: Siap dijalankan di berbagai platform serta di-containerize untuk web production.

---

## 📁 Struktur Direktori

```text
lib/
├── constants/
│   └── colors.dart         # Palet warna aplikasi
├── model/
│   └── todo.dart           # Model data & dummy initial data
├── screens/
│   └── home.dart           # Tampilan utama (Search, List, Input)
├── widgets/
│   └── todo_item.dart      # Komponen widget per item to-do
└── main.dart               # Entry point aplikasi Flutter
```

---

## 🛠️ Prasyarat (Prerequisites)

Pilih salah satu metode yang ingin kamu gunakan:

### Opsi A: Menjalankan Secara Lokal (Flutter SDK)
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi `>= 3.12.0`)
- Web Browser (Chrome/Edge), Android Emulator, atau Windows Desktop support

### Opsi B: Menjalankan Menggunakan Docker
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) sudah terinstal dan aktif.

---

## 💻 1. Cara Menjalankan Secara Lokal (Tanpa Docker)

1. **Clone / Import Repository dari GitHub**:
   Buka terminal di komputer kamu, lalu unduh proyek ini menggunakan Git:
   ```bash
   git clone https://github.com/ifmdk636/task-flow.git
   cd task-flow
   ```

2. **Unduh dependensi**:
   ```bash
   flutter pub get
   ```

2. **Jalankan aplikasi**:
   - Menjalankan di browser (Chrome):
     ```bash
     flutter run -d chrome
     ```
   - Menjalankan di Windows Desktop:
     ```bash
     flutter run -d windows
     ```
   - Menjalankan di perangkat/emulator yang aktif:
     ```bash
     flutter run
     ```

---

## 🐳 2. Cara Menjalankan Menggunakan Docker

Proyek ini telah dikonfigurasi dengan arsitektur **Multi-Stage Build**:
- **Stage 1 (Build)**: Mengompilasi kode Flutter ke Flutter Web Release.
- **Stage 2 (Production)**: Menyajikan file statis menggunakan image ringan **Nginx Alpine** (~40 MB) dengan dukungan konfigurasi Single Page Application (SPA).

### Metode 1: Menggunakan Perintah Docker CLI

1. **Build Image Docker**:
   ```bash
   docker build -t todo-app .
   ```

2. **Jalankan Kontainer**:
   ```bash
   docker run -d -p 8080:80 --name my-todo-app todo-app
   ```

3. **Akses Aplikasi**:
   Buka browser dan kunjungi:
   👉 **[http://localhost:8080](http://localhost:8080)**

4. **Perintah Berguna**:
   - Melihat log kontainer:
     ```bash
     docker logs -f my-todo-app
     ```
   - Menghentikan kontainer:
     ```bash
     docker stop my-todo-app
     ```
   - Menjalankan kembali kontainer yang dihentikan:
     ```bash
     docker start my-todo-app
     ```
   - Menghapus kontainer:
     ```bash
     docker rm -f my-todo-app
     ```

---

### Metode 2: Menggunakan Docker Compose (Lebih Praktis)

1. **Jalankan aplikasi di background**:
   ```bash
   docker compose up -d --build
   ```

2. **Akses Aplikasi**:
   Kunjungi **[http://localhost:8080](http://localhost:8080)** di browser.

3. **Menghentikan aplikasi**:
   ```bash
   docker compose down
   ```

---

## 📝 Konfigurasi Port

Jika port `8080` sudah digunakan oleh aplikasi lain, kamu dapat mengubah mapping port di terminal:
```bash
docker run -d -p 3000:80 --name my-todo-app todo-app
```
*(Aplikasi akan dapat diakses melalui `http://localhost:3000`)*.
