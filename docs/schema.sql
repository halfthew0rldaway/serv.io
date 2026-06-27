CREATE TABLE `User` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(50) NOT NULL DEFAULT 'teknisi',
  `reset_password_token` VARCHAR(255) NULL,
  `reset_password_expires` DATETIME NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Customer` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(255) NOT NULL,
  `nomor_telepon` VARCHAR(50) NOT NULL,
  `alamat` TEXT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Perangkat` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `customer_id` INT NOT NULL,
  `jenis_perangkat` VARCHAR(100) NOT NULL,
  `merek` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  `serial_number` VARCHAR(100) NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`id`) ON DELETE CASCADE
);

CREATE TABLE `TiketServis` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nomor_tiket` VARCHAR(100) NOT NULL UNIQUE,
  `perangkat_id` INT NOT NULL,
  `teknisi_id` INT NULL,
  `keluhan` TEXT NOT NULL,
  `kelengkapan` TEXT NULL,
  `foto_kondisi` JSON NULL,
  `status` VARCHAR(50) NOT NULL DEFAULT 'diterima',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`perangkat_id`) REFERENCES `Perangkat`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`teknisi_id`) REFERENCES `User`(`id`) ON DELETE SET NULL
);

CREATE TABLE `Diagnosis` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tiket_id` INT NOT NULL UNIQUE,
  `masalah` TEXT NOT NULL,
  `solusi` TEXT NOT NULL,
  `estimasi_biaya` DOUBLE NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`tiket_id`) REFERENCES `TiketServis`(`id`) ON DELETE CASCADE
);

CREATE TABLE `LogPerbaikan` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tiket_id` INT NOT NULL,
  `fase` VARCHAR(100) NOT NULL DEFAULT 'Diagnosis',
  `catatan` TEXT NOT NULL,
  `foto_url` LONGTEXT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`tiket_id`) REFERENCES `TiketServis`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Brand` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nama` VARCHAR(100) NOT NULL UNIQUE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Sparepart` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `brand_id` INT NULL,
  `kategori` VARCHAR(100) NOT NULL DEFAULT 'Umum',
  `nama` VARCHAR(255) NOT NULL,
  `stok` INT NOT NULL DEFAULT 0,
  `harga` DOUBLE NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`brand_id`) REFERENCES `Brand`(`id`) ON DELETE RESTRICT
);

CREATE TABLE `PenggunaanSparepart` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tiket_id` INT NOT NULL,
  `sparepart_id` INT NOT NULL,
  `jumlah` INT NOT NULL,
  UNIQUE KEY `penggunaan_unique` (`tiket_id`, `sparepart_id`),
  FOREIGN KEY (`tiket_id`) REFERENCES `TiketServis`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`sparepart_id`) REFERENCES `Sparepart`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Invoice` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tiket_id` INT NOT NULL UNIQUE,
  `biaya_jasa` DOUBLE NOT NULL,
  `biaya_sparepart` DOUBLE NOT NULL,
  `total_biaya` DOUBLE NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`tiket_id`) REFERENCES `TiketServis`(`id`) ON DELETE CASCADE
);

CREATE TABLE `ActivityLog` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NULL,
  `user_nama` VARCHAR(255) NOT NULL,
  `action` TEXT NOT NULL,
  `entity` VARCHAR(100) NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE SET NULL
);
