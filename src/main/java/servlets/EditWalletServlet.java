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
@WebServlet(name = "EditWalletServlet", urlPatterns = { "/EditWalletServlet" })
public class EditWalletServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // Validasi Login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();

        // Menangkap parameter dari form Edit
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        String accountName = request.getParameter("accountName");
        String walletType = request.getParameter("walletType");
        String balanceText = request.getParameter("balance");
        String providerName = request.getParameter("providerName");
        String accountNumber = request.getParameter("accountNumber");

        double balance = 0;
        try {
            balance = Double.parseDouble(balanceText);
        } catch (NumberFormatException e) {
            balance = 0;
        }

        WalletDAO walletDAO = new WalletDAO();
        
        // Memanggil method updateWallet dari DAO
        boolean success = walletDAO.updateWallet(accountId, userId, accountName, balance, walletType, providerName, accountNumber);

        // ==========================================
        // SET PESAN TOAST DI SINI
        // ==========================================
        if (success) {
            session.setAttribute("successMessage", "Wallet updated successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to update wallet.");
        }

        response.sendRedirect(request.getContextPath() + "/wallet");
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
