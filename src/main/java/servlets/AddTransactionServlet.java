package servlets;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TransactionDAO;
import model.User;

@WebServlet(name = "AddTransactionServlet", urlPatterns = { "/AddTransactionServlet" })
public class AddTransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        String redirectTo = request.getParameter("redirectTo");

        String successRedirect;
        String errorRedirect;
        String invalidRedirect;

        if ("transaction".equalsIgnoreCase(redirectTo)) {
            successRedirect = request.getContextPath() + "/transaction?success=add";
            errorRedirect = request.getContextPath() + "/transaction?error=add";
            invalidRedirect = request.getContextPath() + "/transaction?error=invalid";
        } else {
            successRedirect = request.getContextPath() + "/dashboard?success=add";
            errorRedirect = request.getContextPath() + "/dashboard?error=add";
            invalidRedirect = request.getContextPath() + "/dashboard?error=invalid";
        }

        try {
            String accountIdText = request.getParameter("accountId");

            if (accountIdText == null || accountIdText.trim().isEmpty()) {
                accountIdText = request.getParameter("walletId");
            }

            int accountId = Integer.parseInt(accountIdText);
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            String transactionName = request.getParameter("transactionName");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String transactionType = request.getParameter("transactionType");
            String transactionDateText = request.getParameter("transactionDate");
            String note = request.getParameter("note");

            if (transactionName == null || transactionName.trim().isEmpty()) {
                response.sendRedirect(invalidRedirect);
                return;
            }

            if (transactionType == null || transactionType.trim().isEmpty()) {
                transactionType = "expense";
            }

            if (!"income".equalsIgnoreCase(transactionType)
                    && !"expense".equalsIgnoreCase(transactionType)) {
                transactionType = "expense";
            }

            if (note == null) {
                note = "";
            }
            Timestamp transactionDate;

            if (transactionDateText != null && !transactionDateText.trim().isEmpty()) {
                transactionDate = Timestamp.valueOf(transactionDateText + " 00:00:00");
            } else {
                transactionDate = new Timestamp(System.currentTimeMillis());
            }

            TransactionDAO transactionDAO = new TransactionDAO();

            boolean success = transactionDAO.addTransaction(
                    userId,
                    accountId,
                    categoryId,
                    transactionName,
                    amount,
                    transactionType,
                    transactionDate,
                    note);

            if (success) {
                response.sendRedirect(
                        request.getContextPath() + "/dashboard?success=add");
            } else {
                response.sendRedirect(errorRedirect);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(invalidRedirect);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Add Transaction Servlet";
    }
}