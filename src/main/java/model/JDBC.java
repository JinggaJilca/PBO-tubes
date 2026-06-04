package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JDBC {
    
    // Konfigurasi Kredensial Database
    private static final String SERVER_NAME = "fintrack-pbo.database.windows.net";
    private static final String DATABASE_NAME = "fintrack_db"; // Ganti dengan nama database di Azure
    private static final String USERNAME = "fintrackadmin";     // Ganti dengan admin/user database
    private static final String PASSWORD = "adminFintrack26@keren";     // Ganti dengan password database

    // Format URL Koneksi khusus untuk Azure SQL
    private static final String CONNECTION_URL = 
            "jdbc:sqlserver://" + SERVER_NAME + ":1433;"
            + "database=" + DATABASE_NAME + ";"
            + "user=" + USERNAME + ";"
            + "password=" + PASSWORD + ";"
            + "encrypt=true;"
            + "trustServerCertificate=true;"
            + "hostNameInCertificate=*.database.windows.net;"
            + "loginTimeout=30;";

    public static Connection getConnection() {
    Connection connection = null;
    try {
        // BARIS INI WAJIB ADA agar Tomcat mengenali Driver-nya
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
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