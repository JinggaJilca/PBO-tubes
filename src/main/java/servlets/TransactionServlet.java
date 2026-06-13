package servlets;

import dao.TransactionDAO;
import dao.CategoryDAO;
import dao.WalletDAO;

import model.Transaction;
import model.Category;
import model.User;
import model.Wallet;
import dao.DashboardDAO;
import model.DashboardSummary;

import java.time.LocalDate;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "TransactionServlet", urlPatterns = { "/transaction" })
public class TransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");
        int userId = loggedInUser.getUserID();

        String username = loggedInUser.getUsername();

        if (username == null || username.trim().isEmpty()) {
            username = "User";
        }
TransactionDAO transactionDAO = new TransactionDAO();
CategoryDAO categoryDAO = new CategoryDAO();
WalletDAO walletDAO = new WalletDAO();
DashboardDAO dashboardDAO = new DashboardDAO();

LocalDate now = LocalDate.now();
int year = now.getYear();
int month = now.getMonthValue();

DashboardSummary summary = dashboardDAO.getDashboardSummary(userId, year, month);

List<Transaction> transactions = transactionDAO.getTransactionsByUserId(userId);
List<Category> categories = categoryDAO.getAllCategories();
List<Wallet> wallets = walletDAO.getWalletsByUserId(userId);

double totalIncome = 0;
double totalExpense = 0;
double netBalance = 0;

double lastMonthEarnings = 0;
double lastMonthSpending = 0;
double lastMonthBalance = 0;

if (summary != null) {
    totalIncome = summary.getTotalEarnings();
    totalExpense = summary.getTotalSpending();
    netBalance = totalIncome - totalExpense;

    lastMonthEarnings = summary.getLastMonthEarnings();
    lastMonthSpending = summary.getLastMonthSpending();
    lastMonthBalance = summary.getLastMonthBalance();
}

        request.setAttribute("username", username);
        request.setAttribute("transactions", transactions);
        request.setAttribute("categories", categories);
        request.setAttribute("wallets", wallets);
        request.setAttribute("totalIncome", totalIncome);
        request.setAttribute("totalExpense", totalExpense);
        request.setAttribute("netBalance", netBalance);
        request.setAttribute("lastMonthEarnings", lastMonthEarnings);
request.setAttribute("lastMonthSpending", lastMonthSpending);
request.setAttribute("lastMonthBalance", lastMonthBalance);

        request.getRequestDispatcher("/transaction.jsp").forward(request, response);
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
        return "Transaction Servlet";
    }
}