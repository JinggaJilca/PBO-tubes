package dao;

import model.JDBC;
import model.Profile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProfileDAO {

    public Profile getProfileByUserId(int userId) {
        Profile profile = null;

        String sql =
                "SELECT " +
                "u.user_id, " +
                "u.username, " +
                "u.email, " +
                "u.password, " +
                "p.full_name, " +
                "p.phone_number, " +
                "p.address " +
                "FROM users u " +
                "LEFT JOIN profiles p ON u.user_id = p.user_id " +
                "WHERE u.user_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    profile = new Profile();

                    profile.setUserId(rs.getInt("user_id"));
                    profile.setUsername(rs.getString("username"));
                    profile.setEmail(rs.getString("email"));
                    profile.setPassword(rs.getString("password"));
                    profile.setFullName(rs.getString("full_name"));
                    profile.setPhoneNumber(rs.getString("phone_number"));
                    profile.setAddress(rs.getString("address"));
                }
            }

        } catch (SQLException e) {
            System.out.println("Gagal mengambil data profile user.");
            e.printStackTrace();
        }

        return profile;
    }
    public boolean updateProfile(Profile profile) {
    String updateUserSql =
            "UPDATE users SET username = ?, email = ? " +
            "WHERE user_id = ?";

    String checkProfileSql =
            "SELECT profile_id FROM profiles WHERE user_id = ?";

    String updateProfileSql =
            "UPDATE profiles SET full_name = ?, phone_number = ?, address = ? " +
            "WHERE user_id = ?";

    String insertProfileSql =
            "INSERT INTO profiles (user_id, full_name, phone_number, address) " +
            "VALUES (?, ?, ?, ?)";

    try (Connection conn = JDBC.getConnection()) {

        conn.setAutoCommit(false);

        try {
            try (PreparedStatement stmtUser = conn.prepareStatement(updateUserSql)) {
                stmtUser.setString(1, profile.getUsername());
                stmtUser.setString(2, profile.getEmail());
                stmtUser.setInt(3, profile.getUserId());
                stmtUser.executeUpdate();
            }

            // 2. Cek apakah data profile sudah ada
            boolean profileExists = false;

            try (PreparedStatement stmtCheck = conn.prepareStatement(checkProfileSql)) {
                stmtCheck.setInt(1, profile.getUserId());

                try (ResultSet rs = stmtCheck.executeQuery()) {
                    if (rs.next()) {
                        profileExists = true;
                    }
                }
            }
            if (profileExists) {
                try (PreparedStatement stmtProfile = conn.prepareStatement(updateProfileSql)) {
                    stmtProfile.setString(1, profile.getFullName());
                    stmtProfile.setString(2, profile.getPhoneNumber());
                    stmtProfile.setString(3, profile.getAddress());
                    stmtProfile.setInt(4, profile.getUserId());
                    stmtProfile.executeUpdate();
                }
            } 
            else {
                try (PreparedStatement stmtProfile = conn.prepareStatement(insertProfileSql)) {
                    stmtProfile.setInt(1, profile.getUserId());
                    stmtProfile.setString(2, profile.getFullName());
                    stmtProfile.setString(3, profile.getPhoneNumber());
                    stmtProfile.setString(4, profile.getAddress());
                    stmtProfile.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            System.out.println("Gagal update profile, rollback dilakukan.");
            e.printStackTrace();
            return false;
        } finally {
            conn.setAutoCommit(true);
        }

    } catch (SQLException e) {
        System.out.println("Gagal koneksi saat update profile.");
        e.printStackTrace();
        return false;
    }
}
}