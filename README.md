# Serv.io
Sistem Manajemen Bengkel Perbaikan Perangkat Elektronik dengan fitur terintegrasi mulai dari pendaftaran customer, inventarisasi suku cadang, pelacakan status perbaikan, log pengerjaan teknisi, hingga pembuatan invoice pembayaran.

## Tech Stack
- **Frontend**: React.js (Vite), Tailwind CSS, Recharts.
- **Backend**: Node.js, Express.js.
- **Database**: MySQL dengan Prisma ORM.
- **Autentikasi**: JSON Web Token (JWT).

---

## Struktur Relasi Database (ERD)
Sistem ini menggunakan struktur relasional untuk menghubungkan entitas Customer, Perangkat, Tiket Servis, Sparepart, dan Log Perbaikan. 

```mermaid
erDiagram
    User ||--o{ TiketServis : "teknisi_id"
    User ||--o{ ActivityLog : "user_id"
    User {
        Int id PK
        String nama
        String email
        String password
        String role "admin / teknisi"
        DateTime created_at
    }

    Customer ||--o{ Perangkat : "customer_id"
    Customer {
        Int id PK
        String nama
        String nomor_telepon
        String alamat
        DateTime created_at
    }

    Perangkat ||--o{ TiketServis : "perangkat_id"
    Perangkat {
        Int id PK
        Int customer_id FK
        String jenis_perangkat
        String merek
        String model
        String serial_number
        DateTime created_at
    }

    TiketServis ||--o| Diagnosis : "tiket_id"
    TiketServis ||--o{ LogPerbaikan : "tiket_id"
    TiketServis ||--o{ PenggunaanSparepart : "tiket_id"
    TiketServis ||--o| Invoice : "tiket_id"
    TiketServis {
        Int id PK
        String nomor_tiket
        Int perangkat_id FK
        Int teknisi_id FK
        String keluhan
        String kelengkapan
        Json foto_kondisi
        String status
        DateTime created_at
    }

    Diagnosis {
        Int id PK
        Int tiket_id FK
        String masalah
        String solusi
        Float estimasi_biaya
        DateTime created_at
    }

    LogPerbaikan {
        Int id PK
        Int tiket_id FK
        String fase
        String catatan
        String foto_url
        DateTime created_at
    }

    Brand ||--o{ Sparepart : "brand_id"
    Brand {
        Int id PK
        String nama
        DateTime created_at
    }

    Sparepart ||--o{ PenggunaanSparepart : "sparepart_id"
    Sparepart {
        Int id PK
        Int brand_id FK
        String kategori
        String nama
        Int stok
        Float harga
        DateTime created_at
    }

    PenggunaanSparepart {
        Int id PK
        Int tiket_id FK
        Int sparepart_id FK
        Int jumlah
    }

    Invoice {
        Int id PK
        Int tiket_id FK
        Float biaya_jasa
        Float biaya_sparepart
        Float total_biaya
        DateTime created_at
    }

    ActivityLog {
        Int id PK
        Int user_id FK
        String user_nama
        String action
        String entity
        DateTime created_at
    }
```

---

## Diagram Alur (System Flowchart)

```mermaid
flowchart TD
    A[Customer Datang bawa Perangkat] --> B{Pernah Terdaftar?};
    B -- Belum --> C[Admin Mendaftarkan Data Customer];
    B -- Sudah --> D[Admin Mendaftarkan Data Perangkat Baru/Pilih yang Ada];
    C --> D;
    D --> E[Admin Membuat Tiket Servis & Menugaskan Teknisi];
    E --> F[Generate Nomor Resi Tracking];
    
    F --> G[Teknisi Melakukan Diagnosis Perangkat];
    G --> H{Butuh Suku Cadang?};
    H -- Ya --> I[Teknisi Request Sparepart];
    I --> J[Persetujuan Cost oleh Customer];
    J -- Disetujui --> K;
    H -- Tidak --> K[Teknisi Memulai Perbaikan];
    
    K --> L[Teknisi Upload Foto & Catat Log Perbaikan berkala];
    L --> M[Perbaikan Selesai];
    M --> N[Admin Menerbitkan Invoice];
    N --> O[Customer Membayar & Mengambil Barang];
```

---

## Alur Pengguna (Use Case Diagram)

```mermaid
flowchart LR
    Admin([Admin])
    Teknisi([Teknisi])
    Customer([Customer / Publik])

    subgraph System ["Serv.io System"]
        UC1(Kelola Data Customer)
        UC2(Kelola Data Perangkat)
        UC3(Kelola Stok Sparepart)
        UC4(Buat Tiket Servis & Tugaskan Teknisi)
        UC5(Ambil Alih Tiket)
        UC6(Input Diagnosis & Estimasi Biaya)
        UC7(Update Status: Disetujui / Dalam Perbaikan)
        UC8(Tambah Catatan Tiket / Permintaan Customer)
        UC9(Input Log & Dokumentasi Perbaikan)
        UC10(Gunakan Sparepart pada Tiket)
        UC11(Selesaikan Tiket)
        UC12(Terbitkan Invoice)
        UC13(Lihat Dashboard & Statistik)
        UC14(Export Log Aktivitas CSV)
        UC15(Lacak Status Servis)
    end

    Admin --> UC1
    Admin --> UC2
    Admin --> UC3
    Admin --> UC4
    Admin --> UC7
    Admin --> UC8
    Admin --> UC12
    Admin --> UC13
    Admin --> UC14

    Teknisi --> UC5
    Teknisi --> UC6
    Teknisi --> UC9
    Teknisi --> UC10
    Teknisi --> UC11
    Teknisi --> UC13

    Customer --> UC15
```

---

## Cara Instalasi dan Setup

### Prasyarat Sistem
- Node.js versi 18 atau lebih baru.
- MySQL Server (XAMPP / Docker).

### 1. Setup Database
1. Buka MySQL server.
2. Buat database kosong dengan nama `repair_workshop` (atau nama lain).

### 2. Setup Backend
1. Buka terminal, masuk ke direktori `backend`.
2. Jalankan perintah `npm install`.
3. Buat file `.env` di dalam folder `backend` dengan format berikut:
   ```env
   DATABASE_URL="mysql://root:@localhost:3306/repair_workshop"
   JWT_SECRET="rahasia_super_aman"
   PORT=5000
   ```
   *Catatan: Sesuaikan username (root), password, dan nama database jika berbeda.*
4. Sinkronisasi struktur database menggunakan Prisma:
   ```bash
   npx prisma db push
   ```
5. Masukkan data awal (akun Admin, Teknisi, dan data dummy) ke dalam database:
   ```bash
   node seed.js
   ```
6. Jalankan server backend:
   ```bash
   npm run dev
   ```
   *Server akan berjalan di http://localhost:5000.*

### 3. Setup Frontend
1. Buka terminal baru, masuk ke direktori `frontend`.
2. Jalankan perintah `npm install`.
3. Jalankan server frontend:
   ```bash
   npm run dev
   ```
4. Buka URL yang diberikan di terminal (biasanya `http://localhost:5173`) pada browser.

### Akun Akses Default
Gunakan akun berikut untuk login pertama kali (dibuat otomatis oleh script database):
- **Admin**: Email `admin@repair.com` | Password `password123`
- **Teknisi**: Email `teknisi@repair.com` | Password `password123`
