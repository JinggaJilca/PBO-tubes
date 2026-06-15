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

/**
 *
 * @author Julio
 */
@WebServlet(name = "AddWalletServlet", urlPatterns = {"/AddWalletServlet"})
public class AddWalletServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession session = request.getSession(false);

        // int userId = 1;

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();


        String accountName = request.getParameter("accountName");
        String walletType = request.getParameter("walletType");
        String balanceText = request.getParameter("balance");
        String providerName = request.getParameter("providerName");
        String accountNumber = request.getParameter("accountNumber");

        double balance = 0;

        try {
            balance = Double.parseDouble(balanceText);
        } catch (Exception e) {
            balance = 0;
        }

        WalletDAO walletDAO = new WalletDAO();

        boolean success = false;
        
        if ("ewallet".equalsIgnoreCase(walletType)) {
            success = walletDAO.addEWallet(userId, accountName, balance, providerName, accountNumber);
        } else {
            // PERBAIKAN: Kembalikan accountNumber ke pemanggilan physical wallet
            success = walletDAO.addPhysicalWallet(userId, accountName, balance, accountNumber);
        }

        // Opsional: Anda bisa menambahkan logic Notifikasi Toast di sini jika mau
        if (success) {
            session.setAttribute("successMessage", "Wallet added successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to add wallet.");
        }

        response.sendRedirect(request.getContextPath() + "/wallet");
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
