package servlets;

import dao.UserDAO;
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

    private UserDAO userDAO = new UserDAO();

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
        } else {
            response.sendRedirect("login.jsp");
        }
    }

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
}