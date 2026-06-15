package servlets;

import dao.DashboardDAO;
import dao.WalletDAO;
import dao.CategoryDAO;
import model.DashboardSummary;
import model.CategorySpendingSummary;
import model.MonthlyTransactionSummary;
import model.RecentActivity;
import model.Wallet;
import model.Category;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.StringJoiner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        model.User loggedInUser = (model.User) session.getAttribute("user");
        Integer userId = loggedInUser.getUserID();
        
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();

        DashboardDAO dashboardDAO = new DashboardDAO();
        String username = dashboardDAO.getUsernameByUserId(userId);
        DashboardSummary summary = dashboardDAO.getDashboardSummary(userId, year, month);
        List<RecentActivity> recentActivities = dashboardDAO.getRecentActivities(userId, 5);
        List<CategorySpendingSummary> spendingOverview = dashboardDAO.getSpendingOverviewByCategory(userId, year, month);
        double averageExpense = dashboardDAO.getAverageExpense(userId, year, month);

        CategorySpendingSummary largestCategory = null;
        if (spendingOverview != null && !spendingOverview.isEmpty()) {
            largestCategory = spendingOverview.get(0);
        }

        List<MonthlyTransactionSummary> monthlySummary = dashboardDAO.getMonthlyTransactionSummary(userId, year);
        String monthlyLabelsJson = buildMonthlyLabelsJson(monthlySummary);
        String monthlyIncomeJson = buildMonthlyIncomeJson(monthlySummary);
        String monthlyExpenseJson = buildMonthlyExpenseJson(monthlySummary);

        String categoryLabelsJson = buildCategoryLabelsJson(spendingOverview);
        String categoryAmountJson = buildCategoryAmountJson(spendingOverview);
        
        // ==============================================================
        // DATA WALLET & CATEGORY
        // ==============================================================
        WalletDAO walletDAO = new WalletDAO();
        List<Wallet> wallets = walletDAO.getWalletsByUserId(userId);

        CategoryDAO categoryDAO = new CategoryDAO();
        // Menggunakan getAllCategories() sesuai permintaan Anda
        List<Category> categories = categoryDAO.getAllCategories(); 

        request.setAttribute("wallets", wallets);
        request.setAttribute("categories", categories);
        // ==============================================================

        request.setAttribute("username", username);
        request.setAttribute("summary", summary);
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("spendingOverview", spendingOverview);
        request.setAttribute("monthlySummary", monthlySummary);
        request.setAttribute("monthlyLabelsJson", monthlyLabelsJson);
        request.setAttribute("monthlyIncomeJson", monthlyIncomeJson);
        request.setAttribute("monthlyExpenseJson", monthlyExpenseJson);
        request.setAttribute("averageExpense", averageExpense);
        request.setAttribute("largestCategory", largestCategory);
        request.setAttribute("categoryLabelsJson", categoryLabelsJson);
        request.setAttribute("categoryAmountJson", categoryAmountJson);
        
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private String buildMonthlyLabelsJson(List<MonthlyTransactionSummary> monthlySummary) {
        String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        StringJoiner joiner = new StringJoiner(",", "[", "]");
        for (MonthlyTransactionSummary monthly : monthlySummary) {
            int monthIndex = monthly.getMonth() - 1;
            joiner.add("\"" + monthNames[monthIndex] + "\"");
        }
        return joiner.toString();
    }

    private String buildMonthlyIncomeJson(List<MonthlyTransactionSummary> monthlySummary) {
        StringJoiner joiner = new StringJoiner(",", "[", "]");
        for (MonthlyTransactionSummary monthly : monthlySummary) {
            joiner.add(String.valueOf(monthly.getTotalIncome()));
        }
        return joiner.toString();
    }

    private String buildMonthlyExpenseJson(List<MonthlyTransactionSummary> monthlySummary) {
        StringJoiner joiner = new StringJoiner(",", "[", "]");
        for (MonthlyTransactionSummary monthly : monthlySummary) {
            joiner.add(String.valueOf(monthly.getTotalExpense()));
        }
        return joiner.toString();
    }

    private String buildCategoryLabelsJson(List<CategorySpendingSummary> spendingOverview) {
        StringJoiner joiner = new StringJoiner(",", "[", "]");
        for (CategorySpendingSummary category : spendingOverview) {
            joiner.add("\"" + category.getCategoryName() + "\"");
        }
        return joiner.toString();
    }

    private String buildCategoryAmountJson(List<CategorySpendingSummary> spendingOverview) {
        StringJoiner joiner = new StringJoiner(",", "[", "]");
        for (CategorySpendingSummary category : spendingOverview) {
            joiner.add(String.valueOf(category.getTotalAmount()));
        }
        return joiner.toString(); // Ini sudah diperbaiki
    }
}