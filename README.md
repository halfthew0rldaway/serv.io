<div align="center">
    <img src="logo undira.png" alt="Logo" width="120" />
    <h1>Serv.io Platform</h1>
    <p>Enterprise-grade IT Repair & Service Center Management System</p>

<!-- Tech Stack Badges -->
<p align="center">
  <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB" alt="React" />
  <img src="https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="Tailwind" />
  <img src="https://img.shields.io/badge/Vite-B73BFE?style=for-the-badge&logo=vite&logoColor=FFD62E" alt="Vite" />
  <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js" />
  <img src="https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white" alt="Express" />
  <img src="https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
  <img src="https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white" alt="Prisma" />
</p>

</div>

---

## System Previews

<div align="center">
    <img src="ss/preview-1.png" alt="Dashboard Preview" width="800" style="border-radius: 8px; margin-bottom: 15px;" />
    <br/>
    <img src="ss/preview-2.png" alt="Ticket Detail Preview" width="800" style="border-radius: 8px; margin-bottom: 15px;" />
    <br/>
    <img src="ss/preview-3.png" alt="Invoice Preview" width="800" style="border-radius: 8px;" />
</div>

---

## Role-Based Access Control (RBAC) Comparison

Serv.io utilizes strict Segregation of Duties to maintain data integrity and operational security.

| Feature Module | Admin Workspace | Technician Portal | Public Tracking |
| :--- | :---: | :---: | :---: |
| **Pricing Tier / Access** | **Managerial** | **Operational** | **Read-Only** |
| Customer & Device Registration | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - | - |
| Master Data (Spareparts) | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - | - |
| Issue Diagnosis & Estimates | - | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - |
| Activity Logging & Documentation | - | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - |
| Sparepart Consumption | - | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - |
| Invoice Generation | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - | - |
| Ticket Assignment Override | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | - | - |
| Global Analytics Dashboard | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> (Assigned Only) | - |
| Ticket Tracking Status | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> | <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/check.svg" width="16" height="16"> (Via Token) |

---

## Architectural Diagrams

### Entity Relationship Diagram (ERD)
The system employs a normalized relational structure to map entities efficiently.

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

### System Operational Flow
```mermaid
flowchart TD
    A[Customer Arrival] --> B{Existing Customer?};
    B -- No --> C[Admin Registers Customer Profile];
    B -- Yes --> D[Admin Registers Target Device];
    C --> D;
    D --> E[Admin Generates Service Ticket];
    E --> F[System Mints Tracking Token];
    
    F --> G[Technician Conducts Diagnosis];
    G --> H{Requires Spareparts?};
    H -- Yes --> I[Technician Drafts Cost Estimate];
    I --> J[Customer Approval Required];
    J -- Approved --> K;
    H -- No --> K[Technician Initiates Repair Process];
    
    K --> L[Technician Injects Periodic Repair Logs];
    L --> M[Repair Completion Marked];
    M --> N[Admin Generates Official Invoice];
    N --> O[Customer Finalizes Payment & Handover];
```

---

## Deployment & Installation Guide

### Prerequisites
- Node.js (v18.x or superior)
- MySQL Server Environment (Native / Containerized)
- NPM or Yarn Package Manager

### 1. Database Initialization
Deploy a fresh MySQL database schema named `repair_workshop` via your preferred administration tool.

### 2. Backend Orchestration
Navigate into the backend subsystem to configure the API and ORM layer.
```bash
cd backend
npm install
```
Configure your environment variables by generating a `.env` file:
```env
DATABASE_URL="mysql://root:@localhost:3306/repair_workshop"
JWT_SECRET="secure_enterprise_key"
PORT=5000
```
Synchronize the Prisma schema and seed the initial administrative datasets:
```bash
npx prisma db push
node seed.js
npm run dev
```

### 3. Frontend Orchestration
Navigate into the React subsystem to compile the client application.
```bash
cd frontend
npm install
npm run dev
```

### System Credentials
The `seed.js` script provisions default accounts for immediate system access:
- **Administrator**: `admin@repair.com` (Pass: `password123`)
- **Lead Technician**: `teknisi@repair.com` (Pass: `password123`)

---
<div align="center">
    <p>Developed by Universitas Dian Nusantara Development Team</p>
    <p>Wisnu Widya Pradana | Muhammad Aditya | Rhio Isma Rizky Aziz</p>
</div>
