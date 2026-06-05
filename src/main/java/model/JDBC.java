package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JDBC {
    
    // Konfigurasi Kredensial Database
    private static final String DATABASE_NAME = "fintrack_db";
    private static final String USERNAME = "root";    
    private static final String PASSWORD = "";    

// Format URL Koneksi yang benar untuk MySQL
    private static final String CONNECTION_URL = 
            "jdbc:mysql://localhost:3306/" + DATABASE_NAME 
            + "?user=" + USERNAME 
            + "&password=" + PASSWORD;

    public static Connection getConnection() {
    Connection connection = null;
    try {
        // BARIS INI WAJIB ADA agar Tomcat mengenali Driver-nya
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        connection = DriverManager.getConnection(CONNECTION_URL);
    } catch (ClassNotFoundException e) {
        System.out.println("Driver tidak ditemukan: " + e.getMessage());
    } catch (SQLException e) {
        System.out.println("Gagal konek DB: " + e.getMessage());
    }
    return connection;
    }

    // Method main untuk mengetes koneksi langsung dengan menjalankan file ini (Shift + F6)
    public static void main(String[] args) {
        Connection conn = getConnection();
        
        // Tutup koneksi jika berhasil dites
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}