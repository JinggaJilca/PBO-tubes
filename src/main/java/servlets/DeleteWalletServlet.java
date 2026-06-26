package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDAO;
import model.User;

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
            

            boolean success = walletDAO.deleteWallet(accountId, userId);
            
            
            if (success) {
                session.setAttribute("successMessage", "Wallet deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete wallet.");
            }
        } else {
            
            session.setAttribute("errorMessage", "Invalid wallet ID.");
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
            
            
            boolean success = walletDAO.deleteWallet(accountId, userId);
            

            if (success) {
                session.setAttribute("successMessage", "Wallet deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete wallet.");
            }
        } else {

            session.setAttribute("errorMessage", "Invalid wallet ID.");
        }


        response.sendRedirect(request.getContextPath() + "/wallet");
    }
}
