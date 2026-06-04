package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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
            + "trustServerCertificate=false;"
            + "hostNameInCertificate=*.database.windows.net;"
            + "loginTimeout=30;";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Membuka koneksi ke database
            System.out.println("Mencoba terhubung ke Azure SQL Database...");
            connection = DriverManager.getConnection(CONNECTION_URL);
            System.out.println("Koneksi Berhasil!");
        } catch (SQLException e) {
            System.out.println("Koneksi Gagal. Cek pesan error berikut:");
            e.printStackTrace();
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