package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.JDBC;
import model.Wallet;
import model.PhysicalWallet;
import model.EWallet;

public class WalletDAO {

    public List<Wallet> getWalletsByUserId(int userId) {
        List<Wallet> wallets = new ArrayList<>();

        String sql = "SELECT \n" +
                "    aw.account_id, \n" +
                "    aw.user_id, \n" + 
                "    aw.account_name, \n" +
                "    aw.balance, \n" +
                "    CASE \n" +
                "        WHEN pw.account_id IS NOT NULL THEN 'Physical'\n" +
                "        WHEN ew.account_id IS NOT NULL THEN 'E-Wallet'\n" +
                "        ELSE 'General'\n" +
                "    END AS wallet_type,\n" +
                "    COALESCE(pw.provider_name, ew.provider_name) AS provider_name, \n" +
                "    COALESCE(pw.account_number, ew.account_number) AS account_number \n" +
                "FROM account_wallets aw \n" +
                "LEFT JOIN physical_wallet pw ON aw.account_id = pw.account_id \n" +
                "LEFT JOIN ewallet ew ON aw.account_id = ew.account_id \n" +
                "WHERE aw.user_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String type = rs.getString("wallet_type");
                    Wallet wallet;

                    
                    if ("E-Wallet".equals(type)) {
                        wallet = new EWallet();
                        ((EWallet) wallet).setProviderName(rs.getString("provider_name"));
                        ((EWallet) wallet).setAccountNumber(rs.getString("account_number"));
                    } else {
                        wallet = new PhysicalWallet();
                        ((PhysicalWallet) wallet).setAccountNumber(rs.getString("account_number"));
                    }


                    wallet.setAccountId(rs.getInt("account_id"));
                    wallet.setUserId(rs.getInt("user_id"));
                    wallet.setAccountName(rs.getString("account_name"));
                    wallet.setBalance(rs.getDouble("balance"));

                    wallets.add(wallet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR DISINI: " + e.getMessage());
        }

        return wallets;
    }
    
    
    public boolean addWallet(Wallet wallet) {
        String insertAccount = "INSERT INTO account_wallets (user_id, account_name, balance) VALUES (?, ?, ?)";
        
        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtAccount = conn.prepareStatement(insertAccount, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmtAccount.setInt(1, wallet.getUserId());
                stmtAccount.setString(2, wallet.getAccountName());
                stmtAccount.setDouble(3, wallet.getBalance());
                stmtAccount.executeUpdate();

                int newAccountId = 0;
                try (ResultSet keys = stmtAccount.getGeneratedKeys()) {
                    if (keys.next()) {
                        newAccountId = keys.getInt(1);
                    }
                }

                // Cek tipe wallet dengan instance of
                if (wallet instanceof EWallet) {
                    EWallet ew = (EWallet) wallet;
                    String insertEwallet = "INSERT INTO ewallet (account_id, provider_name, account_number) VALUES (?, ?, ?)";
                    try (PreparedStatement stmtEwallet = conn.prepareStatement(insertEwallet)) {
                        stmtEwallet.setInt(1, newAccountId);
                        stmtEwallet.setString(2, ew.getProviderName());
                        stmtEwallet.setString(3, ew.getAccountNumber());
                        stmtEwallet.executeUpdate();
                    }
                } else if (wallet instanceof PhysicalWallet) {
                    PhysicalWallet pw = (PhysicalWallet) wallet;
                    String insertPhysical = "INSERT INTO physical_wallet (account_id, account_number) VALUES (?, ?)";
                    try (PreparedStatement stmtPhysical = conn.prepareStatement(insertPhysical)) {
                        stmtPhysical.setInt(1, newAccountId);
                        stmtPhysical.setString(2, pw.getAccountNumber());
                        stmtPhysical.executeUpdate();
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

    public boolean updateWallet(Wallet wallet) {
        String updateAccount = "UPDATE account_wallets SET account_name = ?, balance = ? WHERE account_id = ? AND user_id = ?";
        String deletePhysical = "DELETE FROM physical_wallet WHERE account_id = ?";
        String deleteEwallet = "DELETE FROM ewallet WHERE account_id = ?";

        try (Connection conn = JDBC.getConnection()) {
            conn.setAutoCommit(false);

            try {
                int updatedRows;
                try (PreparedStatement stmt = conn.prepareStatement(updateAccount)) {
                    stmt.setString(1, wallet.getAccountName());
                    stmt.setDouble(2, wallet.getBalance());
                    stmt.setInt(3, wallet.getAccountId());
                    stmt.setInt(4, wallet.getUserId());
                    updatedRows = stmt.executeUpdate();
                }

                if (updatedRows == 0) {
                    conn.rollback();
                    return false;
                }

                
                try (PreparedStatement stmt = conn.prepareStatement(deletePhysical)) {
                    stmt.setInt(1, wallet.getAccountId());
                    stmt.executeUpdate();
                }
                try (PreparedStatement stmt = conn.prepareStatement(deleteEwallet)) {
                    stmt.setInt(1, wallet.getAccountId());
                    stmt.executeUpdate();
                }

                
                if (wallet instanceof EWallet) {
                    EWallet ew = (EWallet) wallet;
                    String insertEwallet = "INSERT INTO ewallet (account_id, provider_name, account_number) VALUES (?, ?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(insertEwallet)) {
                        stmt.setInt(1, ew.getAccountId());
                        stmt.setString(2, ew.getProviderName());
                        stmt.setString(3, ew.getAccountNumber());
                        stmt.executeUpdate();
                    }
                } else if (wallet instanceof PhysicalWallet) {
                    PhysicalWallet pw = (PhysicalWallet) wallet;
                    String insertPhysical = "INSERT INTO physical_wallet (account_id, account_number) VALUES (?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(insertPhysical)) {
                        stmt.setInt(1, pw.getAccountId());
                        stmt.setString(2, pw.getAccountNumber());
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
        String sql = "DELETE FROM account_wallets WHERE account_id = ? AND user_id = ?";

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