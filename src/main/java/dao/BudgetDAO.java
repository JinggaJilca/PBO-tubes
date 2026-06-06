/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Budget;
import model.JDBC;

/**
 *
 * @author ASUS
 */
public class BudgetDAO {
    private final int CURRENT_USER_ID = 1;
    
    // 1. Mengambil total budget bulanan (user_id = 1)
    public double getTotalBudgetByUser(int userId) {
            // Menggunakan SUM(category_budget) dan memfilter rentang tanggal aktif
            String sql = "SELECT SUM(category_budget) FROM budgets " +
                         "WHERE user_id = ? " +
                         "AND CURRENT_DATE >= start_date " +
                         "AND CURRENT_DATE <= end_date";

            try (Connection conn = JDBC.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getDouble(1); // Mengembalikan hasil penjumlahan
                    }
                }
            } catch (SQLException e) { 
                e.printStackTrace(); 
            }
            return 0.0;
        }

    // 2. Mengambil total pengeluaran bulan ini (user_id = 1)
    public double getSpentAmountByUser() {
        String sql = "SELECT SUM(amount) FROM transactions " +
                     "WHERE user_id = 1 AND MONTH(transaction_date) = MONTH(CURRENT_DATE()) " +
                     "AND YEAR(transaction_date) = YEAR(CURRENT_DATE())";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
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
}
