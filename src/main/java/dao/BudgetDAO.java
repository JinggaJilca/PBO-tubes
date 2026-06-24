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

    // 2. Mengambil total pengeluaran user berdasarkan kategori yang punya budget
    public double getSpentAmountByUser(int userId) {

        String sql = "SELECT COALESCE(SUM(t.amount), 0) AS total_spent " +
                "FROM transactions t " +
                "INNER JOIN budgets b ON t.category_id = b.category_id " +
                "WHERE t.user_id = ? " +
                "AND b.user_id = ? " +
                "AND t.transaction_type = 'expense' " +
                "AND DATE(t.transaction_date) BETWEEN b.start_date AND b.end_date";

        double totalSpent = 0.0;

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalSpent = rs.getDouble("total_spent");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalSpent;
    }

    // 3. Menambahkan budget
    public boolean addBudget(Budget budget) {
        // PERBAIKAN: Menyesuaikan jumlah parameter VALUES(?) menjadi 6 sesuai jumlah kolom
        String sql = "INSERT INTO budgets (user_id, category_id, category_budget, threshold, start_date, end_date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, budget.getUserId());
            stmt.setInt(2, budget.getCategoryId());
            // PERBAIKAN: total_budget dihapus, langsung menggunakan category_budget
            stmt.setDouble(3, budget.getCategoryBudget());
            stmt.setDouble(4, budget.getThreshold());
            stmt.setDate(5, budget.getStartDate());
            stmt.setDate(6, budget.getEndDate());

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

    // 5. Mengambil pengeluaran per kategori sesuai periode budget
    public double getSpentAmountByCategory(int userId, int categoryId) {

        String sql = "SELECT COALESCE(SUM(t.amount), 0) AS total_spent " +
                "FROM transactions t " +
                "INNER JOIN budgets b ON t.category_id = b.category_id " +
                "WHERE t.user_id = ? " +
                "AND b.user_id = ? " +
                "AND t.category_id = ? " +
                "AND b.category_id = ? " +
                "AND t.transaction_type = 'expense' " +
                "AND DATE(t.transaction_date) BETWEEN b.start_date AND b.end_date";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            stmt.setInt(3, categoryId);
            stmt.setInt(4, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_spent");
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

    // 7. Method untuk mengedit/memperbarui budget
    public boolean updateBudget(Budget budget) {

        String sql = "UPDATE budgets SET category_budget = ?, threshold = ? WHERE budget_id = ?";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            // PERBAIKAN: Index disesuaikan setelah total_budget dihapus
            stmt.setDouble(1, budget.getCategoryBudget());
            stmt.setDouble(2, budget.getThreshold());
            stmt.setInt(3, budget.getBudgetId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}