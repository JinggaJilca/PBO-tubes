package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDAO;

@WebServlet(name = "AddWalletServlet", urlPatterns = {"/AddWalletServlet"})
public class AddWalletServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

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
            
            success = walletDAO.addPhysicalWallet(userId, accountName, balance, accountNumber);
        }

        
        if (success) {
            session.setAttribute("successMessage", "Wallet added successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to add wallet.");
        }

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

        if (success) {
            session.setAttribute("successMessage", "Wallet added successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to add wallet.");
        }

        response.sendRedirect(request.getContextPath() + "/wallet");
    }

}
