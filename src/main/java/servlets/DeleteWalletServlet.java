/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDAO;
import model.User;

/**
 *
 * @author Julio
 */
@WebServlet(name = "DeleteWalletServlet", urlPatterns = { "/DeleteWalletServlet" })
public class DeleteWalletServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        String accountIdText = request.getParameter("accountId");

        int accountId = 0;

        try {
            accountId = Integer.parseInt(accountIdText);
        } catch (Exception e) {
            accountId = 0;
        }

        if (accountId != 0) {
            WalletDAO walletDAO = new WalletDAO();
            
            // Tangkap nilai true/false dari proses delete
            boolean success = walletDAO.deleteWallet(accountId, userId);
            
            // Set pesan ke dalam session berdasarkan hasilnya
            if (success) {
                session.setAttribute("successMessage", "Wallet deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete wallet.");
            }
        } else {
            // Jika ID gagal di-parse atau bernilai 0
            session.setAttribute("errorMessage", "Invalid wallet ID.");
        }

        // Kembali ke halaman wallet untuk memicu Toast
        response.sendRedirect(request.getContextPath() + "/wallet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        String accountIdText = request.getParameter("accountId");

        int accountId = 0;

        try {
            accountId = Integer.parseInt(accountIdText);
        } catch (Exception e) {
            accountId = 0;
        }

        if (accountId != 0) {
            WalletDAO walletDAO = new WalletDAO();
            
            // Tangkap nilai true/false dari proses delete
            boolean success = walletDAO.deleteWallet(accountId, userId);
            
            // Set pesan ke dalam session berdasarkan hasilnya
            if (success) {
                session.setAttribute("successMessage", "Wallet deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete wallet.");
            }
        } else {
            // Jika ID gagal di-parse atau bernilai 0
            session.setAttribute("errorMessage", "Invalid wallet ID.");
        }

        // Kembali ke halaman wallet untuk memicu Toast
        response.sendRedirect(request.getContextPath() + "/wallet");
    }
}
