package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDAO;

@WebServlet(name = "EditWalletServlet", urlPatterns = { "/EditWalletServlet" })
public class EditWalletServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();

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
        
        boolean success = walletDAO.updateWallet(accountId, userId, accountName, balance, walletType, providerName, accountNumber);

        if (success) {
            session.setAttribute("successMessage", "Wallet updated successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to update wallet.");
        }

        response.sendRedirect(request.getContextPath() + "/wallet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
