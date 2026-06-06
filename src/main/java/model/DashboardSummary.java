package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DashboardSummary {
    private double totalBalance;
    private double totalEarnings;
    private double totalSpending;
    private double lastMonthEarnings;
    private double lastMonthSpending;
    private double lastMonthBalance;

    public DashboardSummary() {
    }

    public DashboardSummary(double totalBalance, double totalEarnings, double totalSpending,
            double lastMonthEarnings, double lastMonthSpending, double lastMonthBalance) {
        this.totalBalance = totalBalance;
        this.totalEarnings = totalEarnings;
        this.totalSpending = totalSpending;
        this.lastMonthEarnings = lastMonthEarnings;
        this.lastMonthSpending = lastMonthSpending;
        this.lastMonthBalance = lastMonthBalance;
    }

    public double getTotalBalance() {
        return totalBalance;
    }

    public double getTotalEarnings() {
        return totalEarnings;
    }

    public double getTotalSpending() {
        return totalSpending;
    }

    public double getLastMonthEarnings() {
        return lastMonthEarnings;
    }

    public double getLastMonthSpending() {
        return lastMonthSpending;
    }

    public double getLastMonthBalance() {
        return lastMonthBalance;
    }

    public void setTotalBalance(double totalBalance) {
        this.totalBalance = totalBalance;
    }

    public void setTotalEarnings(double totalEarnings) {
        this.totalEarnings = totalEarnings;
    }

    public void setTotalSpending(double totalSpending) {
        this.totalSpending = totalSpending;
    }

    public void setLastMonthEarnings(double lastMonthEarnings) {
        this.lastMonthEarnings = lastMonthEarnings;
    }

    public void setLastMonthSpending(double lastMonthSpending) {
        this.lastMonthSpending = lastMonthSpending;
    }

    public void setLastMonthBalance(double lastMonthBalance) {
        this.lastMonthBalance = lastMonthBalance;
    }

    public boolean addTransaction(int userId, int accountId, int categoryId,
            String transactionName, double amount,
            String transactionType, String note) {

        String insertTransactionSql = "INSERT INTO transactions " +
                "(user_id, account_id, category_id, transaction_name, amount, transaction_type, transaction_date, note) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, NOW(), ?)";

        String updateWalletSql;

        if ("income".equalsIgnoreCase(transactionType)) {
            updateWalletSql = "UPDATE account_wallets SET balance = balance + ? " +
                    "WHERE account_id = ? AND user_id = ?";
        } else {
            updateWalletSql = "UPDATE account_wallets SET balance = balance - ? " +
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
}
