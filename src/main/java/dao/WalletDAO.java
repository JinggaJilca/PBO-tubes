package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.JDBC;
import model.Wallet;

public class WalletDAO {
    public List<Wallet> getWalletsByUserId(int userId) {
        List<Wallet> wallets = new ArrayList<>();

        String sql = "SELECT " +
                "aw.account_id, " +
                "aw.user_id, " +
                "aw.account_name, " +
                "aw.balance, " +
                "ew.provider_name, " +
                "ew.account_number, " +
                "CASE " +
                "   WHEN ew.account_id IS NOT NULL THEN 'ewallet' " +
                "   ELSE 'physical' " +
                "END AS wallet_type " +
                "FROM account_wallets aw " +
                "LEFT JOIN ewallet ew ON aw.account_id = ew.account_id " +
                "LEFT JOIN physical_wallet pw ON aw.account_id = pw.account_id " +
                "WHERE aw.user_id = ? " +
                "ORDER BY aw.account_id ASC";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Wallet wallet = new Wallet();

                    wallet.setAccountId(rs.getInt("account_id"));
                    wallet.setUserId(rs.getInt("user_id"));
                    wallet.setAccountName(rs.getString("account_name"));
                    wallet.setBalance(rs.getDouble("balance"));
                    wallet.setWalletType(rs.getString("wallet_type"));
                    wallet.setProviderName(rs.getString("provider_name"));
                    wallet.setAccountNumber(rs.getString("account_number"));

                    wallets.add(wallet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return wallets;
    }

    public boolean addPhysicalWallet(int userId, String accountName, double balance) {
        String insertAccount = "INSERT INTO account_wallets (user_id, account_name, balance) " +
                "VALUES (?, ?, ?)";

        String insertPhysical = "INSERT INTO physical_wallet (account_id) VALUES (?)";

        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtAccount = conn.prepareStatement(insertAccount,
                    PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtAccount.setInt(1, userId);
                stmtAccount.setString(2, accountName);
                stmtAccount.setDouble(3, balance);
                stmtAccount.executeUpdate();

                int newAccountId = 0;

                try (ResultSet keys = stmtAccount.getGeneratedKeys()) {
                    if (keys.next()) {
                        newAccountId = keys.getInt(1);
                    }
                }

                try (PreparedStatement stmtPhysical = conn.prepareStatement(insertPhysical)) {
                    stmtPhysical.setInt(1, newAccountId);
                    stmtPhysical.executeUpdate();
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

    public boolean addEWallet(int userId, String accountName, double balance,
            String providerName, String accountNumber) {
        String insertAccount = "INSERT INTO account_wallets (user_id, account_name, balance) " +
                "VALUES (?, ?, ?)";

        String insertEwallet = "INSERT INTO ewallet (account_id, provider_name, account_number) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtAccount = conn.prepareStatement(insertAccount,
                    PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtAccount.setInt(1, userId);
                stmtAccount.setString(2, accountName);
                stmtAccount.setDouble(3, balance);
                stmtAccount.executeUpdate();

                int newAccountId = 0;

                try (ResultSet keys = stmtAccount.getGeneratedKeys()) {
                    if (keys.next()) {
                        newAccountId = keys.getInt(1);
                    }
                }

                try (PreparedStatement stmtEwallet = conn.prepareStatement(insertEwallet)) {
                    stmtEwallet.setInt(1, newAccountId);
                    stmtEwallet.setString(2, providerName);
                    stmtEwallet.setString(3, accountNumber);
                    stmtEwallet.executeUpdate();
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

    public boolean updateWallet(int accountId, int userId, String accountName, double balance,
            String walletType, String providerName, String accountNumber) {

        String updateAccount = "UPDATE account_wallets " +
                "SET account_name = ?, balance = ? " +
                "WHERE account_id = ? AND user_id = ?";

        String deletePhysical = "DELETE FROM physical_wallet WHERE account_id = ?";

        String deleteEwallet = "DELETE FROM ewallet WHERE account_id = ?";

        String insertPhysical = "INSERT INTO physical_wallet (account_id) VALUES (?)";

        String insertEwallet = "INSERT INTO ewallet (account_id, provider_name, account_number) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try {
                int updatedRows;

                try (PreparedStatement stmt = conn.prepareStatement(updateAccount)) {
                    stmt.setString(1, accountName);
                    stmt.setDouble(2, balance);
                    stmt.setInt(3, accountId);
                    stmt.setInt(4, userId);
                    updatedRows = stmt.executeUpdate();
                }

                if (updatedRows == 0) {
                    conn.rollback();
                    return false;
                }

                try (PreparedStatement stmt = conn.prepareStatement(deletePhysical)) {
                    stmt.setInt(1, accountId);
                    stmt.executeUpdate();
                }

                try (PreparedStatement stmt = conn.prepareStatement(deleteEwallet)) {
                    stmt.setInt(1, accountId);
                    stmt.executeUpdate();
                }

                if ("ewallet".equalsIgnoreCase(walletType)) {
                    try (PreparedStatement stmt = conn.prepareStatement(insertEwallet)) {
                        stmt.setInt(1, accountId);
                        stmt.setString(2, providerName);
                        stmt.setString(3, accountNumber);
                        stmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement stmt = conn.prepareStatement(insertPhysical)) {
                        stmt.setInt(1, accountId);
                        stmt.executeUpdate();
                    }
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

    public boolean deleteWallet(int accountId, int userId) {
        String sql = "DELETE FROM account_wallets " +
                "WHERE account_id = ? AND user_id = ?";

        try (Connection conn = JDBC.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, accountId);
            stmt.setInt(2, userId);

            int rowsDeleted = stmt.executeUpdate();

            return rowsDeleted > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
