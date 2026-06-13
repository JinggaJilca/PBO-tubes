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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BudgetDAO dao = new BudgetDAO();
        CategoryDAO categoryDao = new CategoryDAO(); // Wajib diinisialisasi untuk ambil nama kategori
        int userId = 1;

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

        // PERBAIKAN: Gunakan method getAllBudgetsByUser, bukan getTotalBudgetByUser
        List<Budget> userBudgets = dao.getAllBudgetsByUser(userId); 

        if (userBudgets != null) {
            for (Budget b : userBudgets) {
                Map<String, Object> cardData = new HashMap<>();

                // Ambil detail Kategori menggunakan categoryDao
                Category cat = categoryDao.getCategoryById(b.getCategoryId());
                String categoryName = (cat != null) ? cat.getName() : "Unknown Category";

                // PERBAIKAN: Gunakan instance 'dao' (BudgetDAO), bukan class statis BudgetDao
                double spentForCategory = dao.getSpentAmountByCategory(userId, b.getCategoryId());

                double remainingForCategory = b.getCategoryBudget() - spentForCategory;
                double cardPercentage = (b.getCategoryBudget() > 0) ? (spentForCategory / b.getCategoryBudget()) * 100 : 0;

                // Masukkan semua data ke dalam Map
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
           String action = request.getParameter("action");
           HttpSession session = request.getSession();

           // Ambil userId dari session dengan fallback
           Integer sessionUserId = (Integer) session.getAttribute("userId");
           int userId = (sessionUserId != null) ? sessionUserId : 1; 

           if ("add".equals(action)) {
               try {
                   // 1. Ambil data dari form modal
                   int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                   double totalBudget = Double.parseDouble(request.getParameter("totalBudget"));
                   double categoryBudget = Double.parseDouble(request.getParameter("amount"));
                   double threshold = Double.parseDouble(request.getParameter("threshold"));

                   // Ambil tanggal dari input type="date"
                   java.sql.Date startDate = java.sql.Date.valueOf(request.getParameter("startDate"));
                   java.sql.Date endDate = java.sql.Date.valueOf(request.getParameter("endDate"));

                   // 2. Buat objek Budget
                   Budget newBudget = new Budget();
                   newBudget.setUserId(userId);
                   newBudget.setCategoryId(categoryId);
                   newBudget.setTotalBudget(totalBudget);
                   newBudget.setCategoryBudget(categoryBudget);
                   newBudget.setThreshold(threshold);
                   newBudget.setStartDate(startDate);
                   newBudget.setEndDate(endDate);

                   // 3. Simpan ke Database
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
               response.sendRedirect("budget"); // Kembali ke halaman daftar budget
           }
       }
    
    @Override
        public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    }




