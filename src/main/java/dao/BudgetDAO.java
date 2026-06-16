
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Budget;
import model.JDBC;

public class BudgetDAO {
    
   // 1. Mengambil total budget bulanan user
    public double getTotalBudgetByUser(int userId) {
        // Fungsi SUM() otomatis akan menjumlahkan semua kategori yang user_id nya sama
        String sql = "SELECT SUM(category_budget) FROM budgets " +
                     "WHERE user_id = ? ";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return 0.0;
    }

    // 2. Mengambil total pengeluaran bulan ini
    public double getSpentAmountByUser(int userId) {
        
        String sql = "SELECT SUM(amount) FROM transactions " +
                     "WHERE user_id = ? AND transaction_type = 'expense'";
                     
        double totalSpent = 0.0;
        
        // PERBAIKAN 2: Pisahkan executeQuery dari inisialisasi try-with-resources
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId); // Wajib set parameter DULU
            
            try (ResultSet rs = stmt.executeQuery()) { // BARU dieksekusi di sini
                if (rs.next()) {
                    totalSpent = rs.getDouble(1);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return totalSpent;
    }

    // 3. Menambahkan budget
    public boolean addBudget(Budget budget) {
        String sql = "INSERT INTO budgets (user_id, category_id, total_budget, category_budget, threshold, start_date, end_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
                     
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, budget.getUserId());
            stmt.setInt(2, budget.getCategoryId());
            stmt.setDouble(3, budget.getTotalBudget());
            stmt.setDouble(4, budget.getCategoryBudget());
            stmt.setDouble(5, budget.getThreshold());
            stmt.setDate(6, budget.getStartDate());
            stmt.setDate(7, budget.getEndDate());
            
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // 4. Mengambil semua list budget milik user (Dibutuhkan oleh Servlet untuk Looping Kartu)
    public List<Budget> getAllBudgetsByUser(int userId) {
        List<Budget> list = new ArrayList<>();
        String sql = "SELECT * FROM budgets WHERE user_id = ?";
        
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Budget b = new Budget();
                    b.setBudgetId(rs.getInt("budget_id"));
                    b.setCategoryId(rs.getInt("category_id"));
                    b.setCategoryBudget(rs.getDouble("category_budget"));
                    b.setThreshold(rs.getDouble("threshold"));
                    // Anda juga bisa set start_date dan end_date jika diperlukan
                    list.add(b);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 5. Mengambil total pengeluaran per kategori secara spesifik (Dibutuhkan oleh Servlet)
    public double getSpentAmountByCategory(int userId, int categoryId) {
        String sql = "SELECT SUM(amount) FROM transactions " +
                     "WHERE user_id = ? AND category_id = ? AND transaction_type = 'expense'";
                     
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId);
            stmt.setInt(2, categoryId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return 0.0;
    }
    
    // 6. Method untuk menghapus budget berdasarkan budget_id
    public boolean deleteBudget(int budgetId) {
        String sql = "DELETE FROM budgets WHERE budget_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, budgetId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // Method untuk mengedit/memperbarui budget
    public boolean updateBudget(Budget budget) {
        // Kita memperbarui total_budget, category_budget, dan threshold
        String sql = "UPDATE budgets SET total_budget = ?, category_budget = ?, threshold = ? WHERE budget_id = ?";
        
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setDouble(1, budget.getTotalBudget());
            stmt.setDouble(2, budget.getCategoryBudget());
            stmt.setDouble(3, budget.getThreshold());
            stmt.setInt(4, budget.getBudgetId());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
}
