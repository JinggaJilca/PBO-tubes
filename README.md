# 🚀 FinTrack

### 📄 Class Diagram [Klik disini](https://app.diagrams.net/#G1TZTk5Ohq2ep4Crkf8NV1nfEAZyzS9t2O#%7B%22pageId%22%3A%22SSOpVx6V4zdg8AZLdFHl%22%7D)


## 🛠️ Tech Stack
Proyek ini mengadopsi pola arsitektur MVC (Model-View-Controller) secara terstruktur.
* **Frontend:** HTML5, Bootstrap 5, CSS3 Kustom.
* **Icons:** [Solar Icons by Iconify](https://icones.js.org/collection/solar).
* **Backend:** Java EE, JSP (JavaServer Pages), Servlets.
* **Database:** Microsoft Azure Database (Cloud) / MySQL.
* **Version Control:** Git & GitHub.

## 👥 Tim Pengembang (Kelompok)

| No | Nama Lengkap | NIM | Peran |
| :---: | :--- | :--- | :--- |
| 1 | **Nayyara Aurelia Putri** | 103072400097 | Database |
| 2 | **Jingga Jil Carissa** | 103072400121 | Backend |
| 3 | **Bethari Nevyta Amaries** | 103072430016 | Frontend |
| 4 | **A’ilah Nailul Fa’izah** | 103072400042 | Database |
| 5 | **Julio Chrysanto Tanlain** | 103072400110 | Backend |
| 6 | **Misael Arafian Fonataba** | 103072400017 | Frontend |


## 🚧 Batas Akses File
Jangan mengedit file di luar ranah tim Anda untuk menghindari bentrok kode (*merge conflict*).

**🎨 Frontend (Gunakan VS Code)**
* **Fokus:** UI/UX, Desain, Git (*Clone*, *Pull*, *Push*).
* **Direktori:** HANYA `src/main/webapp/`
* **File:** `.jsp`, `.css`, `.js`, dan gambar.

**⚙️ Backend (Gunakan NetBeans)**
* **Fokus:** Logika Bisnis, Servlet, Database, Kontrol Server Tomcat.
* **Direktori:** `src/main/java/` dan file konfigurasi.
* **File:** `.java`, `pom.xml`, dan `web.xml`.

---

## 🔄 Alur Kerja (Workflow)

**Backend (NetBeans): Pusat Server**
1. Buka proyek FinTrack di NetBeans.
2. Lakukan *Clean and Build*.
3. **Jalankan Server:** Tekan **Run/Deploy** di NetBeans. (Server Tomcat *wajib* dikontrol sepenuhnya dari NetBeans).

**Frontend (VS Code): Editor & Git**
1. **Buka Proyek:** Gunakan VS Code untuk melakukan *Clone* repositori.
2. **Mulai Kerja:** Selalu lakukan `git pull` lewat terminal VS Code sebelum mendesain.
3. **Edit & Lihat Hasil:** Edit file `.jsp`. Karena server sudah dijalankan oleh Backend, cukup *Save* (`Ctrl + S`) di VS Code lalu *Refresh* browser untuk melihat hasilnya. Tidak perlu *build/run* di VS Code!
4. **Selesai Kerja:** Lakukan `git add .`, `git commit`, dan `git push` via VS Code.

---

## ⚠️ Aturan Wajib
1. **Jangan Kunci Folder Deploy:** Tim Frontend **HANYA** boleh membuka folder *source code* asli (`.../FinTrack`). Dilarang keras membuka folder `C:\xampp\tomcat\webapps\` di VS Code agar *deploy* NetBeans tidak *error*.
2. **Pemanggilan File JSP:** Jika file saling sejajar di satu folder (misal `template.jsp` dan `navbar.jsp`), panggil langsung tanpa garis miring: `<%@ include file="navbar.jsp" %>`.
3. **Sinkronisasi URL:** Pastikan URL pada `action` form (Frontend) sama persis dengan *routing* URL Servlet (Backend).




