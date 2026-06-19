package servlets;

import dao.BudgetDAO;
import dao.CategoryDAO;
import model.Budget;
import model.Category;
import model.User;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addbudget")
public class AddBudgetServlet extends HttpServlet {

    // Menampilkan halaman Add Budget
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

        CategoryDAO catDao = new CategoryDAO();

        // Kalau kategori kamu global, ini boleh
        List<Category> categoryList = catDao.getAllCategories();

        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("addbudget.jsp").forward(request, response);
    }

    // Memproses data form saat tombol Save ditekan
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

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            /*
             * Threshold disimpan sebagai persen.
             * Contoh:
             * budget = 12000
             * thresholdValue = 9600
             * thresholdPercentage = 80
             */
            double thresholdValue = Double.parseDouble(request.getParameter("threshold"));
            double thresholdPercentage = (thresholdValue / amount) * 100;

            LocalDate startOfMonth = LocalDate.now().withDayOfMonth(1);
            LocalDate endOfMonth = LocalDate.now().withDayOfMonth(startOfMonth.lengthOfMonth());

            Budget newBudget = new Budget();
            newBudget.setUserId(userId);
            newBudget.setCategoryId(categoryId);
            newBudget.setTotalBudget(amount);
            newBudget.setCategoryBudget(amount);
            newBudget.setThreshold(thresholdPercentage);
            newBudget.setStartDate(java.sql.Date.valueOf(startOfMonth));
            newBudget.setEndDate(java.sql.Date.valueOf(endOfMonth));

            BudgetDAO dao = new BudgetDAO();
            boolean isSuccess = dao.addBudget(newBudget);

            if (isSuccess) {
                session.setAttribute("successMessage", "New budget added successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to add budget. Please try again.");
            }

            response.sendRedirect(request.getContextPath() + "/budget");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred. Make sure all fields are filled correctly.");
            response.sendRedirect(request.getContextPath() + "/addbudget");
        }
    }
}