package servlets;

import dao.*;
import model.User;
import java.io.IOException;

// Menggunakan impor javax.servlet sesuai server kamu
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    
    private LoginDAO userDAO = new LoginDAO();
    private RegisterDAO registerDAO = new RegisterDAO();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        // Jika URL adalah /auth?action=register, arahkan ke form register
        if ("register".equals(action)) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } 
        // Jika URL adalah /auth?action=logout, proses logout
        else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Hapus sesi
            }
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
        } 
        // Default: Jika tidak ada action spesifik, selalu tampilkan halaman Login
        else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            processLogin(request, response);
        } else if ("register".equals(action)){
            processRegister(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
// --- METHOD UNTUK LOGIN ---
    private void processLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String emailOrUsername = request.getParameter("emailOrUsername");
        String password = request.getParameter("password");

        User loggedInUser = userDAO.authenticateUser(emailOrUsername, password);

        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser); 
            response.sendRedirect("dashboard.jsp"); 
        } else {
            request.setAttribute("errorMessage", "Email/Username atau Password salah!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
// --- METHOD UNTUK REGISTER    
    private void processRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("regisUsername");
        String email = request.getParameter("regisEmail");
        String password = request.getParameter("regisPassword");
        String confirmPassword = request.getParameter("regisConfirmPassword");
        
        // 1. Cek kecocokan password di sisi server
        if (confirmPassword != null && !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Password tidak cocok!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
    
        if (registerDAO.isUserAda(username, email)) {
            request.setAttribute("errorMessage", "Username atau Email sudah terdaftar!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            User newUser = new User();
            
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPassword(password); 
            
            boolean success = registerDAO.addUser(newUser);

            if (success) {
                // 1. Ini untuk catatan/log Anda sendiri di console server
                System.out.println("[BERHASIL] Menambahkan pengguna"); 
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Terjadi kesalahan sistem. Registrasi gagal.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }

}