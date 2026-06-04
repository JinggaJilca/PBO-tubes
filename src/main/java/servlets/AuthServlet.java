package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Menentukan URL endpoint sesuai dengan action di form JSP kamu
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Mengambil parameter '?action=...' dari URL
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            processLogin(request, response);
        } else {
            // Jika action tidak dikenali, kembalikan ke halaman login
            response.sendRedirect("login.jsp");
        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Ambil data dari form input
        String emailOrUsername = request.getParameter("emailOrUsername");
        String password = request.getParameter("password");

        // 2. Validasi ke Database (Disini kamu menghubungkan dengan Azure SQL-mu nanti)
        boolean isValidUser = authenticateUser(emailOrUsername, password);

        if (isValidUser) {
            // 3a. Jika Login BERHASIL: Buat session dan arahkan ke dashboard
            HttpSession session = request.getSession();
            session.setAttribute("user", emailOrUsername); // Menyimpan identitas user di sesi
            
            // Redirect ke halaman utama setelah login (misal: dashboard.jsp)
            response.sendRedirect("dashboard.jsp"); 
        } else {
            // 3b. Jika Login GAGAL: Set pesan error dan kembalikan ke halaman login
            request.setAttribute("errorMessage", "Email/Username atau Password salah!");
            
            // Menggunakan RequestDispatcher agar atribut errorMessage bisa dibaca di login.jsp
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Method bantuan untuk simulasi validasi (Ganti dengan kueri Database sungguhan nantinya)
    private boolean authenticateUser(String username, String password) {
        // TODO: Gunakan DatabaseConnection.java yang kita buat sebelumnya untuk mengecek tabel User
        // Contoh Hardcode sementara untuk testing:
        return ("admin".equals(username) && "admin123".equals(password));
    }
}