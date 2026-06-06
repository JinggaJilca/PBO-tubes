/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.BudgetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Budget;

@WebServlet("/budget")
public class BudgetServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            // Contoh perhitungan di BudgetServlet
            double totalBudget = 20000000.00; // Ambil dari database
            double spentAmount = 13890000.99; // Hasil SUM(amount) dari transaksi
            double remainingAmount = totalBudget - spentAmount;
            double percentage = (spentAmount / totalBudget) * 100;

            request.setAttribute("totalBudget", totalBudget);
            request.setAttribute("spentAmount", spentAmount);
            request.setAttribute("remainingAmount", remainingAmount);
            request.setAttribute("percentage", Math.round(percentage));

            request.getRequestDispatcher("budget.jsp").forward(request, response);
            request.getRequestDispatcher("budget.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BudgetDAO dao = new BudgetDAO();
    
        double totalBudget = dao.getTotalBudgetByUser();
        double spentAmount = dao.getSpentAmountByUser();
        double remainingAmount = totalBudget - spentAmount;

        // Mencegah pembagian nol dan menghitung persentase
        double percentage = (totalBudget > 0) ? (spentAmount / totalBudget) * 100 : 0;

        request.setAttribute("totalBudget", totalBudget);
        request.setAttribute("spentAmount", spentAmount);
        request.setAttribute("remainingAmount", remainingAmount);
        request.setAttribute("percentage", Math.round(percentage));

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




