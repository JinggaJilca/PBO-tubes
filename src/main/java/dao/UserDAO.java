package dao;

import model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Method untuk mengecek kecocokan email/username dan password
    public User authenticateUser(String emailOrUsername, String password) {
        User user = null;
        
        // Kueri SQL: Cek apakah (email = input ATAU username = input) DAN password = input
        String sql = "SELECT * FROM Users WHERE (email = ? OR username = ?) AND password = ?";

        // Menggunakan try-with-resources agar koneksi otomatis tertutup
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Mengisi parameter tanda tanya (?) pada kueri SQL
            stmt.setString(1, emailOrUsername); // Untuk pengecekan email
            stmt.setString(2, emailOrUsername); // Untuk pengecekan username
            stmt.setString(3, password);        // Untuk pengecekan password

            try (ResultSet rs = stmt.executeQuery()) {
                // Jika data ditemukan di database
                if (rs.next()) {
                    user = new User();
                    user.setUserID(rs.getInt("id")); // Sesuaikan nama kolom "id" dengan di Azure
                    user.setUsername(rs.getString("username")); // Sesuaikan nama kolom
                    user.setEmail(rs.getString("email"));
                    // Sengaja tidak menyimpan password ke object User demi keamanan
                }
            }
        } catch (SQLException e) {
            System.out.println("Error saat autentikasi user: " + e.getMessage());
            e.printStackTrace();
        }

        // Jika user ditemukan akan mengembalikan object User, jika tidak akan mengembalikan null
        return user; 
    }
}