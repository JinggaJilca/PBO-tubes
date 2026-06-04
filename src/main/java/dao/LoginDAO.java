package dao;

import model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class LoginDAO {

    public User authenticateUser(String emailOrUsername, String password) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE (email = ? OR username = ?) AND password = ?";

        // Memanggil class JDBC
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, emailOrUsername); 
            stmt.setString(2, emailOrUsername); 
            stmt.setString(3, password);        

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();

                    user.setUserID(rs.getInt("user_id")); // Sesuaikan nama kolom "id" dengan di Azure
                    user.setUsername(rs.getString("username")); // Sesuaikan nama kolom
                    user.setEmail(rs.getString("email"));
                    // Menyimpan password ke object user (opsional, tapi sah-sah saja)
                    user.setPassword(rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error saat autentikasi user: " + e.getMessage());
            e.printStackTrace();
        } catch (NullPointerException e) {
            System.out.println("Koneksi gagal dibuat (conn is null). Cek pesan error di konsol output NetBeans.");
        }

        return user; 
    }
}