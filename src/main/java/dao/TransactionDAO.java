package dao;

import model.JDBC;
import model.Transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public List<Transaction> getTransactionsByUserId(int userId) {
        List<Transaction> transactions = new ArrayList<>();

        String sql = "SELECT " +
                "t.transaction_id, " +
                "t.user_id, " +
                "t.account_id, " +
                "t.category_id, " +
                "t.transaction_name, " +
                "t.amount, " +
                "t.transaction_type, " +
                "t.transaction_date, " +
                "t.note, " +
                "c.name AS category_name, " +
                "aw.account_name AS wallet_name " +
                "FROM transactions t " +
                "LEFT JOIN categories c ON t.category_id = c.category_id " +
                "LEFT JOIN account_wallets aw ON t.account_id = aw.account_id " +
                "WHERE t.user_id = ? " +
                "ORDER BY t.transaction_date DESC, t.transaction_id DESC";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Transaction trx = new Transaction();

                    trx.setTransactionId(rs.getInt("transaction_id"));
                    trx.setUserId(rs.getInt("user_id"));
                    trx.setAccountId(rs.getInt("account_id"));
                    trx.setCategoryId(rs.getInt("category_id"));
                    trx.setTransactionName(rs.getString("transaction_name"));
                    trx.setAmount(rs.getDouble("amount"));
                    trx.setTransactionType(rs.getString("transaction_type"));
                    trx.setTransactionDate(rs.getTimestamp("transaction_date"));
                    trx.setNote(rs.getString("note"));
                    trx.setCategoryName(rs.getString("category_name"));
                    trx.setWalletName(rs.getString("wallet_name"));

                    transactions.add(trx);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return transactions;
    }

    public double getTotalIncomeByUserId(int userId) {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total_income " +
                "FROM transactions " +
                "WHERE user_id = ? AND transaction_type = 'income'";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_income");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public double getTotalExpenseByUserId(int userId) {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS total_expense " +
                "FROM transactions " +
                "WHERE user_id = ? AND transaction_type = 'expense'";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_expense");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean addTransaction(int userId, int accountId, int categoryId,
            String transactionName, double amount,
            String transactionType,
            Timestamp transactionDate,
            String note) {

        String insertTransactionSql = "INSERT INTO transactions " +
                "(user_id, account_id, category_id, transaction_name, amount, transaction_type, transaction_date, note) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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
                    stmt.setTimestamp(7, transactionDate);
                    stmt.setString(8, note);
                    stmt.executeUpdate();
                }

                try (PreparedStatement stmt = conn.prepareStatement(updateWalletSql)) {
                    stmt.setDouble(1, amount);
                    stmt.setInt(2, accountId);
                    stmt.setInt(3, userId);

                    int updatedRows = stmt.executeUpdate();

                    if (updatedRows == 0) {
                        conn.rollback();
                        return false;
                    }
                }
                if ("expense".equalsIgnoreCase(transactionType)) {
                    NotificationDAO notificationDAO = new NotificationDAO();
                    notificationDAO.checkBudgetAfterExpense(conn, userId, categoryId);
                }

                conn.commit();
                return true;

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTransaction(int transactionId, int userId) {
        String selectTransaction = "SELECT account_id, transaction_type, amount " +
                "FROM transactions " +
                "WHERE transaction_id = ? AND user_id = ?";

        String deleteTransaction = "DELETE FROM transactions " +
                "WHERE transaction_id = ? AND user_id = ?";

        String rollbackIncome = "UPDATE account_wallets " +
                "SET balance = balance - ? " +
                "WHERE account_id = ? AND user_id = ?";

        String rollbackExpense = "UPDATE account_wallets " +
                "SET balance = balance + ? " +
                "WHERE account_id = ? AND user_id = ?";

        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try {
                int accountId = 0;
                String transactionType = "";
                double amount = 0;

                try (PreparedStatement stmt = conn.prepareStatement(selectTransaction)) {
                    stmt.setInt(1, transactionId);
                    stmt.setInt(2, userId);

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            accountId = rs.getInt("account_id");
                            transactionType = rs.getString("transaction_type");
                            amount = rs.getDouble("amount");
                        } else {
                            conn.rollback();
                            return false;
                        }
                    }
                }

                String rollbackSql;

                if ("income".equalsIgnoreCase(transactionType)) {
                    rollbackSql = rollbackIncome;
                } else {
                    rollbackSql = rollbackExpense;
                }

                try (PreparedStatement stmt = conn.prepareStatement(rollbackSql)) {
                    stmt.setDouble(1, amount);
                    stmt.setInt(2, accountId);
                    stmt.setInt(3, userId);
                    stmt.executeUpdate();
                }

                try (PreparedStatement stmt = conn.prepareStatement(deleteTransaction)) {
                    stmt.setInt(1, transactionId);
                    stmt.setInt(2, userId);
                    stmt.executeUpdate();
                }

                conn.commit();
                return true;

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}