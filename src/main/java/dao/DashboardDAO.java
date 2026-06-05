package dao;

import model.JDBC;
import model.CategorySpendingSummary;
import model.DashboardSummary;
import model.MonthlyTransactionSummary;
import model.RecentActivity;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {
    public boolean addTransaction(int userId, int accountId, int categoryId,
                              String transactionName, double amount,
                              String transactionType, String note) {

    String insertTransactionSql =
            "INSERT INTO transactions " +
            "(user_id, account_id, category_id, transaction_name, amount, transaction_type, transaction_date, note) " +
            "VALUES (?, ?, ?, ?, ?, ?, NOW(), ?)";

    String updateWalletSql;

    if ("income".equalsIgnoreCase(transactionType)) {
        updateWalletSql =
                "UPDATE account_wallets SET balance = balance + ? " +
                "WHERE account_id = ? AND user_id = ?";
    } else {
        updateWalletSql =
                "UPDATE account_wallets SET balance = balance - ? " +
                "WHERE account_id = ? AND user_id = ?";
    }

    try (Connection conn = JDBC.getConnection()) {

        conn.setAutoCommit(false);

        try {
            try (PreparedStatement stmt = conn.prepareStatement(insertTransactionSql)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, accountId);
                stmt.setInt(3, categoryId);
                stmt.setString(4, transactionName);
                stmt.setDouble(5, amount);
                stmt.setString(6, transactionType);
                stmt.setString(7, note);
                stmt.executeUpdate();
            }

            try (PreparedStatement stmt = conn.prepareStatement(updateWalletSql)) {
                stmt.setDouble(1, amount);
                stmt.setInt(2, accountId);
                stmt.setInt(3, userId);
                stmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            System.out.println("Gagal tambah transaksi, rollback dilakukan.");
            e.printStackTrace();
            return false;
        } finally {
            conn.setAutoCommit(true);
        }

    } catch (SQLException e) {
        System.out.println("Gagal koneksi saat tambah transaksi.");
        e.printStackTrace();
        return false;
    }
}

    public DashboardSummary getDashboardSummary(int userID, int year, int month) {
        LocalDate startMonth = LocalDate.of(year, month, 1);
        LocalDate endMonthExclusive = startMonth.plusMonths(1);

        LocalDate startLastMonth = startMonth.minusMonths(1);
        LocalDate endLastMonthExclusive = startMonth;

        double totalBalance = getTotalBalance(userID);
        double totalEarnings = getTotalTransactionByType(userID, "income", startMonth, endMonthExclusive);
        double totalSpending = getTotalTransactionByType(userID, "expense", startMonth, endMonthExclusive);

        double lastMonthEarnings = getTotalTransactionByType(userID, "income", startLastMonth, endLastMonthExclusive);
        double lastMonthSpending = getTotalTransactionByType(userID, "expense", startLastMonth, endLastMonthExclusive);

        double lastMonthBalance = lastMonthEarnings - lastMonthSpending;

        return new DashboardSummary(
                totalBalance,
                totalEarnings,
                totalSpending,
                lastMonthEarnings,
                lastMonthSpending,
                lastMonthBalance
        );
    }

    private double getTotalBalance(int userID) {
        String sql =
                "SELECT COALESCE(SUM(balance), 0) AS total_balance " +
                "FROM account_wallets " +
                "WHERE user_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_balance");
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil total balance dashboard.");
            e.printStackTrace();
        }

        return 0;
    }

    private double getTotalTransactionByType(int userID, String type, LocalDate startDate, LocalDate endDateExclusive) {
        String sql =
                "SELECT COALESCE(SUM(amount), 0) AS total_amount " +
                "FROM transactions " +
                "WHERE user_id = ? " +
                "AND transaction_type = ? " +
                "AND transaction_date >= ? " +
                "AND transaction_date < ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setString(2, type);
            stmt.setTimestamp(3, Timestamp.valueOf(startDate.atStartOfDay()));
            stmt.setTimestamp(4, Timestamp.valueOf(endDateExclusive.atStartOfDay()));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_amount");
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil total transaksi dashboard.");
            e.printStackTrace();
        }

        return 0;
    }

    public List<CategorySpendingSummary> getSpendingOverviewByCategory(int userID, int year, int month) {
        List<CategorySpendingSummary> data = new ArrayList<>();

        LocalDate startMonth = LocalDate.of(year, month, 1);
        LocalDate endMonthExclusive = startMonth.plusMonths(1);

        double totalSpending = getTotalTransactionByType(userID, "expense", startMonth, endMonthExclusive);

        String sql =
                "SELECT c.name AS category_name, " +
                "COALESCE(SUM(t.amount), 0) AS total_amount " +
                "FROM transactions t " +
                "JOIN categories c ON t.category_id = c.category_id " +
                "WHERE t.user_id = ? " +
                "AND t.transaction_type = 'expense' " +
                "AND t.transaction_date >= ? " +
                "AND t.transaction_date < ? " +
                "GROUP BY c.name " +
                "ORDER BY total_amount DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setTimestamp(2, Timestamp.valueOf(startMonth.atStartOfDay()));
            stmt.setTimestamp(3, Timestamp.valueOf(endMonthExclusive.atStartOfDay()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    double totalAmount = rs.getDouble("total_amount");
                    double percentage = 0;

                    if (totalSpending > 0) {
                        percentage = (totalAmount / totalSpending) * 100;
                    }

                    data.add(new CategorySpendingSummary(
                            rs.getString("category_name"),
                            totalAmount,
                            percentage
                    ));
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil spending overview.");
            e.printStackTrace();
        }

        return data;
    }

    public List<MonthlyTransactionSummary> getMonthlyTransactionSummary(int userID, int year) {
        List<MonthlyTransactionSummary> summaries = new ArrayList<>();

        for (int i = 1; i <= 12; i++) {
            summaries.add(new MonthlyTransactionSummary(i, 0, 0));
        }

        LocalDate startYear = LocalDate.of(year, 1, 1);
        LocalDate endYearExclusive = startYear.plusYears(1);

        String sql =
                "SELECT MONTH(transaction_date) AS transaction_month, " +
                "transaction_type, " +
                "COALESCE(SUM(amount), 0) AS total_amount " +
                "FROM transactions " +
                "WHERE user_id = ? " +
                "AND transaction_date >= ? " +
                "AND transaction_date < ? " +
                "GROUP BY MONTH(transaction_date), transaction_type " +
                "ORDER BY transaction_month";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
                
            stmt.setInt(1, userID);
            stmt.setTimestamp(2, Timestamp.valueOf(startYear.atStartOfDay()));
            stmt.setTimestamp(3, Timestamp.valueOf(endYearExclusive.atStartOfDay()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int transactionMonth = rs.getInt("transaction_month");
                    String type = rs.getString("transaction_type");
                    double totalAmount = rs.getDouble("total_amount");

                    MonthlyTransactionSummary summary = summaries.get(transactionMonth - 1);

                    if ("income".equalsIgnoreCase(type)) {
                        summary.setTotalIncome(totalAmount);
                    } else if ("expense".equalsIgnoreCase(type)) {
                        summary.setTotalExpense(totalAmount);
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil monthly transaction summary.");
            e.printStackTrace();
        }

        return summaries;
    }

    public List<RecentActivity> getRecentActivities(int userID, int limit) {
        List<RecentActivity> activities = new ArrayList<>();

        if (limit <= 0) {
            limit = 5;
        }

        String sql =
                "SELECT " +
        "t.transaction_id, " +
        "c.name AS category_name, " +
        "t.transaction_name, " +
        "t.amount, " +
        "t.transaction_type, " +
        "DATE_FORMAT(t.transaction_date, '%Y-%m-%d') AS transaction_date_only, " +
        "DATE_FORMAT(t.transaction_date, '%H:%i:%s') AS transaction_time_only, " +
        "t.note " +
        "FROM transactions t " +
        "JOIN categories c ON t.category_id = c.category_id " +
        "WHERE t.user_id = ? " +
        "ORDER BY t.transaction_date DESC " +
        "LIMIT ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            stmt.setInt(2, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(new RecentActivity(
                            rs.getInt("transaction_id"),
                            rs.getString("category_name"),
                            rs.getString("transaction_name"),
                            rs.getDouble("amount"),
                            rs.getString("transaction_type"),
                            rs.getString("transaction_date_only"),
                            rs.getString("transaction_time_only"),
                            rs.getString("note")
                    ));
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil recent activity.");
            e.printStackTrace();
        }

        return activities;
        
    }

    public String getUsernameByUserId(int userId) {
    String sql = "SELECT username FROM users WHERE user_id = ?";

    try (Connection conn = JDBC.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, userId);

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getString("username");
            }
        }

    } catch (SQLException e) {
        System.out.println("Gagal mengambil username user.");
        e.printStackTrace();
    }

    return "User";
}

public List<RecentActivity> getExportTransactions(int userID, int year, int month) {
    List<RecentActivity> activities = new ArrayList<>();

    LocalDate startMonth = LocalDate.of(year, month, 1);
    LocalDate endMonthExclusive = startMonth.plusMonths(1);

    String sql =
            "SELECT " +
            "t.transaction_id, " +
            "c.name AS category_name, " +
            "t.transaction_name, " +
            "t.amount, " +
            "t.transaction_type, " +
            "DATE_FORMAT(t.transaction_date, '%Y-%m-%d') AS transaction_date_only, " +
            "DATE_FORMAT(t.transaction_date, '%H:%i:%s') AS transaction_time_only, " +
            "t.note " +
            "FROM transactions t " +
            "JOIN categories c ON t.category_id = c.category_id " +
            "WHERE t.user_id = ? " +
            "AND t.transaction_date >= ? " +
            "AND t.transaction_date < ? " +
            "ORDER BY t.transaction_date DESC";

    try (Connection conn = JDBC.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, userID);
        stmt.setTimestamp(2, Timestamp.valueOf(startMonth.atStartOfDay()));
        stmt.setTimestamp(3, Timestamp.valueOf(endMonthExclusive.atStartOfDay()));

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                activities.add(new RecentActivity(
                        rs.getInt("transaction_id"),
                        rs.getString("category_name"),
                        rs.getString("transaction_name"),
                        rs.getDouble("amount"),
                        rs.getString("transaction_type"),
                        rs.getString("transaction_date_only"),
                        rs.getString("transaction_time_only"),
                        rs.getString("note")
                ));
            }
        }

    } catch (SQLException e) {
        System.out.println("Gagal mengambil data export transaksi dashboard.");
        e.printStackTrace();
    }

    return activities;
}
}