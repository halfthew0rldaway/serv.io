# Desain UML - Serv.io

Dokumen ini berisi diagram-diagram UML yang menggambarkan arsitektur sistem, alur proses bisnis, dan peran-peran yang terlibat di dalam platform Serv.io.

> **Catatan**: File `.puml` di folder `docs/` dapat di-preview menggunakan ekstensi PlantUML di VSCode (`Alt + D`).

## Daftar Diagram

| File | Deskripsi |
|------|-----------|
| `use_case_diagram.puml` | Interaksi aktor (Admin, Teknisi, Customer) dengan fitur sistem |
| `activity_diagram.puml` | Alur status tiket servis dari Diterima hingga Diambil |
| `class_diagram.puml` | Struktur relasi antar entitas data (10 tabel) |
| `schema.sql` | Script DDL MySQL untuk pembuatan tabel |

## Ringkasan Hak Akses (RBAC)

### Admin
- Kelola data **Customer** (CRUD)
- Kelola data **Perangkat** (CRUD)
- Kelola stok **Sparepart** (CRUD)
- **Buat** Tiket Servis & tugaskan teknisi
- Update status: **Disetujui**, **Dalam Perbaikan**, **Diambil**
- Tambah **catatan tiket** dari permintaan customer
- **Terbitkan** Invoice pembayaran
- Akses **Dashboard** & statistik
- **Export** log aktivitas harian (CSV)

### Teknisi
- **Ambil alih** tiket (Diterima → assign diri sendiri)
- Input **Diagnosis** & estimasi biaya (wajib isi log diagnosis dulu)
- Input **Log Perbaikan** & dokumentasi foto
- **Gunakan Sparepart** pada tiket (bukan mengelola stok)
- **Selesaikan** tiket (wajib isi log perbaikan dulu)
- Akses **Dashboard** teknisi

### Customer / Publik
- **Lacak** status servis via nomor tiket atau nomor telepon (tanpa login)
