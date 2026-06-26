# 🚀 FinTrack

### 📄 Class Diagram [Klik disini](https://app.diagrams.net/#G1TZTk5Ohq2ep4Crkf8NV1nfEAZyzS9t2O#%7B%22pageId%22%3A%22SSOpVx6V4zdg8AZLdFHl%22%7D)


## 🛠️ Tech Stack
Proyek ini mengadopsi pola arsitektur MVC (Model-View-Controller) secara terstruktur.
* **Frontend:** HTML5, Bootstrap 5, CSS3 Kustom.
* **Icons:** [Solar Icons by Iconify](https://icones.js.org/collection/solar).
* **Backend:** Java EE, JSP (JavaServer Pages), Servlets.
* **Database:** MySQL.
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

## 💻 KONFIGURASI APLIKASI

### 📦 LANGKAH 1: SETUP PROJECT GIT via VS Code
1. Buat atau pilih folder kosong di laptop untuk menyimpan project.
2. Buka folder dengan klik **File** ➡️ **Open Folder** `(Ctrl + K + Ctrl + O)` ➡️ Pilih folder yang sudah di buat.
3. Buka Terminal Baru.
4. Ketik "git clone https://github.com/JinggaJilca/PBO-tubes" (tanpa tanda petik) pada terminal, lalu tekan **Enter**.

### 🗃️ LANGKAH 2: IMPORT DATABASE di XAMPP
1. Buka XAMPP, lalu **Start** layanan Apache, dan MySQL.
2. Klik menu New di sebelah kiri untuk membuat database baru ➡️ Masukkan nama DB "fintrack_db" ➡️ Klik Create.
3. Klik database tersebut, lalu pilih tab Import di bagian atas.
4. Klik Choose File ➡️ Buka folder Git ➡️ Pilih file pbo-fintrack.sql dari folder "database".
5. Gulir ke Bawah, lalu klik tombol Import (atau Go).

### ☕ LANGKAH 3: OPEN dan RUN PROJECT di NetBeans
1. Buat Apache NetBeans IDE.
2. Klik menu File ➡️ Open Project (atau tekan Ctrl + Shift + O).
3. Cari dan arahkan ke folder project yang telah di clone sebelumnya.
4. Pilih projectnya, lalu klik Open Project.
5. Selanjutnya klik kanan pada project ➡️ tekan menu Clean dan Build > lalu tekan Run.

### 📢 CARA LOGIN APLIKASI 📢
Karena database kami secara otomatis mengenerate data dummy secara acak. Sehingga untuk mengetahui **Username** dan **Password** dapat di cek secara langsung di database.
1. Buka XAMPP, lalu **Start** layanan Apache, dan MySQL. 
2. Pilih database "fintrack_db".
3. Buka tabel users.
4. Pilih username dan password yang ingin digunakan.
