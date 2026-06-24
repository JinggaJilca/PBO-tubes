package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TransactionDAO;
import model.User;

@WebServlet(name = "DeleteTransactionServlet", urlPatterns = { "/transaction/delete" })
public class DeleteTransactionServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        String transactionIdText = request.getParameter("transactionId");

        int transactionId = 0;
        boolean success = false;

        try {
            transactionId = Integer.parseInt(transactionIdText);
        } catch (Exception e) {
            transactionId = 0;
        }

        if (transactionId != 0) {
            TransactionDAO transactionDAO = new TransactionDAO();
            success = transactionDAO.deleteTransaction(transactionId, userId);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/transaction?success=delete");
        } else {
            response.sendRedirect(request.getContextPath() + "/transaction?error=delete");
        }
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
