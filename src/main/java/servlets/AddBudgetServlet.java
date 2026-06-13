package servlets;

import dao.BudgetDAO;
import dao.CategoryDAO;
import model.Budget;
import model.Category;

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
        int userId = 1;

        // Ambil daftar kategori milik user untuk dropdown
        CategoryDAO catDao = new CategoryDAO();
        List<Category> categoryList = catDao.getAllCategories();
 
        
        request.setAttribute("categoryList", categoryList);
        request.getRequestDispatcher("addbudget.jsp").forward(request, response);
    }

    // Memproses data form saat tombol Save ditekan
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        Integer sessionUserId = (Integer) session.getAttribute("userId");
        int userId = (sessionUserId != null) ? sessionUserId : 1; 

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            double amount = Double.parseDouble(request.getParameter("amount"));

            double thresholdValue = Double.parseDouble(request.getParameter("threshold"));
            double thresholdPercentage = (thresholdValue / amount) * 100;

            // 2. Awal bulan sampai akhir bulan ini)
            LocalDate startOfMonth = LocalDate.now().withDayOfMonth(1);
            LocalDate endOfMonth = LocalDate.now().withDayOfMonth(startOfMonth.lengthOfMonth());

            // 3. Masukkan ke dalam objek Budget
            Budget newBudget = new Budget();
            newBudget.setUserId(userId);
            newBudget.setCategoryId(categoryId);
            newBudget.setTotalBudget(amount); 
            newBudget.setCategoryBudget(amount); 
            newBudget.setThreshold(thresholdPercentage);
            newBudget.setStartDate(java.sql.Date.valueOf(startOfMonth));
            newBudget.setEndDate(java.sql.Date.valueOf(endOfMonth));

            // 4. Simpan ke database via DAO
            BudgetDAO dao = new BudgetDAO();
            boolean isSuccess = dao.addBudget(newBudget);

            // 5. Berikan feedback dan Redirect
            if (isSuccess) {
                session.setAttribute("successMessage", "New budget added successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to add budget. Please try again.");
            }
            
            // Redirect kembali ke halaman utama budget
            response.sendRedirect("budget");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred. Make sure all fields are filled correctly.");
            response.sendRedirect(request.getContextPath() + "/addbudget");
        }
    }
}