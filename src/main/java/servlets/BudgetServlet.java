package servlets;

import dao.BudgetDAO;
import dao.CategoryDAO;
import model.Budget;
import model.Category;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/budget")
public class BudgetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                // [START] SESSION
                // 1. Ambil session yang sedang berjalan (false berarti jangan buat session baru jika belum ada)
                HttpSession session = request.getSession(false);

                // 2. Validasi Keamanan: Cek apakah session ada DAN atribut "user" sudah diset (sudah login)
                if (session == null || session.getAttribute("user") == null) {
                    // Jika belum login, tendang kembali ke halaman login
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return; // Wajib return agar kode di bawahnya tidak dieksekusi
                }

                // 3. Tarik objek User dari session (lakukan Casting)
                model.User loggedInUser = (model.User) session.getAttribute("user");

                // 4. Dapatkan userId-nya
                int userId = loggedInUser.getUserID();
                // [END] SESSION
        BudgetDAO dao = new BudgetDAO();
        CategoryDAO categoryDao = new CategoryDAO(); // Wajib diinisialisasi untuk ambil nama kategori

        // 1. DATA RINGKASAN (PROGRESS BAR BESAR)
        double totalBudget = dao.getTotalBudgetByUser(userId);
        double spentAmount = dao.getSpentAmountByUser(userId);
        double remainingAmount = totalBudget - spentAmount;
        double percentage = (totalBudget > 0) ? (spentAmount / totalBudget) * 100 : 0;

        request.setAttribute("totalBudget", totalBudget);
        request.setAttribute("spentAmount", spentAmount);
        request.setAttribute("remainingAmount", remainingAmount);
        request.setAttribute("percentage", Math.round(percentage));

        // 2. DATA KARTU BUDGET (GRID)
        List<Map<String, Object>> budgetCards = new ArrayList<>();

        List<Budget> userBudgets = dao.getAllBudgetsByUser(userId);

        if (userBudgets != null) {
            for (Budget b : userBudgets) {
                Map<String, Object> cardData = new HashMap<>();

                // Ambil detail Kategori menggunakan categoryDao
                Category cat = categoryDao.getCategoryById(b.getCategoryId());
                String categoryName = (cat != null) ? cat.getName() : "Unknown Category";

                double spentForCategory = dao.getSpentAmountByCategory(userId, b.getCategoryId());
                double remainingForCategory = b.getCategoryBudget() - spentForCategory;
                double cardPercentage = (b.getCategoryBudget() > 0) ? (spentForCategory / b.getCategoryBudget()) * 100 : 0;

                // ========================================================
                // PERBAIKAN: Masukkan budgetId agar bisa ditangkap oleh JSP
                // ========================================================
                cardData.put("budgetId", b.getBudgetId()); 
                
                cardData.put("categoryName", categoryName);
                cardData.put("categoryBudget", b.getCategoryBudget());
                cardData.put("remainingAmount", remainingForCategory);
                cardData.put("percentage", Math.round(cardPercentage));
                cardData.put("threshold", b.getThreshold());

                budgetCards.add(cardData);
            }
        }

        // Lempar List Map tersebut ke JSP
        request.setAttribute("budgetCards", budgetCards);

        request.getRequestDispatcher("budget.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                                // [START] SESSION
                // 1. Ambil session yang sedang berjalan (false berarti jangan buat session baru jika belum ada)
                HttpSession session = request.getSession(false);

                // 2. Validasi Keamanan: Cek apakah session ada DAN atribut "user" sudah diset (sudah login)
                if (session == null || session.getAttribute("user") == null) {
                    // Jika belum login, tendang kembali ke halaman login
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return; // Wajib return agar kode di bawahnya tidak dieksekusi
                }

                // 3. Tarik objek User dari session (lakukan Casting)
                model.User loggedInUser = (model.User) session.getAttribute("user");

                // 4. Dapatkan userId-nya
                int userId = loggedInUser.getUserID();
                // [END] SESSION
                
        String action = request.getParameter("action");
        String idParam = request.getParameter("budgetId");


        if ("add".equals(action)) {
            try {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                // Jika totalBudget tidak ada di form, Anda bisa menggunakan 'amount' untuk keduanya
                double categoryBudget = Double.parseDouble(request.getParameter("amount"));
                double totalBudget = categoryBudget; 
                double threshold = Double.parseDouble(request.getParameter("threshold"));

                // PERBAIKAN: Generate tanggal otomatis (Awal bulan hingga akhir bulan)
                java.time.LocalDate startOfMonth = java.time.LocalDate.now().withDayOfMonth(1);
                java.time.LocalDate endOfMonth = java.time.LocalDate.now().withDayOfMonth(startOfMonth.lengthOfMonth());
                
                java.sql.Date startDate = java.sql.Date.valueOf(startOfMonth);
                java.sql.Date endDate = java.sql.Date.valueOf(endOfMonth);

                Budget newBudget = new Budget();
                newBudget.setUserId(userId);
                newBudget.setCategoryId(categoryId);
                newBudget.setTotalBudget(totalBudget);
                newBudget.setCategoryBudget(categoryBudget);
                newBudget.setThreshold(threshold);
                newBudget.setStartDate(startDate);
                newBudget.setEndDate(endDate);

                BudgetDAO dao = new BudgetDAO();
                boolean success = dao.addBudget(newBudget);

                if (success) {
                    session.setAttribute("successMessage", "Budget set successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to set budget.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Error parsing data: " + e.getMessage());
            }

            
        } else if ("delete".equals(action)) {
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int budgetId = Integer.parseInt(idParam);
                    BudgetDAO dao = new BudgetDAO();
                    boolean success = dao.deleteBudget(budgetId);

                    if (success) {
                        session.setAttribute("successMessage", "Budget deleted successfully!");
                    } else {
                        session.setAttribute("errorMessage", "Failed to delete budget.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "Invalid ID format.");
                }
            } else {
                session.setAttribute("errorMessage", "Budget ID is missing.");
            }
            
        } else if ("edit".equals(action)) {
            try {
                int budgetId = Integer.parseInt(idParam);
                double amount = Double.parseDouble(request.getParameter("amount"));
                double threshold = Double.parseDouble(request.getParameter("threshold"));

                Budget budgetToUpdate = new Budget();
                budgetToUpdate.setBudgetId(budgetId);
                budgetToUpdate.setTotalBudget(amount); 
                budgetToUpdate.setCategoryBudget(amount);
                budgetToUpdate.setThreshold(threshold);

                BudgetDAO dao = new BudgetDAO();
                boolean success = dao.updateBudget(budgetToUpdate);

                if (success) {
                    session.setAttribute("successMessage", "Budget updated successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to update budget.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Invalid input format.");
            }
        }
           
        // PERBAIKAN: Redirect hanya dipanggil SATU KALI di akhir method
        response.sendRedirect(request.getContextPath() + "/budget");
    }

    @Override
    public String getServletInfo() {
        return "Budget Management Servlet";
    }
}