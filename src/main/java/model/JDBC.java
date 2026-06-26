//package model;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//public class JDBC {
//    
//    private static final String DATABASE_NAME = "fintrack_db";
//    private static final String USERNAME = "root";    
//    private static final String PASSWORD = "root";    
//    private static final String CONNECTION_URL = 
//            "jdbc:mysql://localhost:8889/" + DATABASE_NAME + "?useSSL=false&serverTimezone=Asia/Jakarta";
//    public static Connection getConnection() {
//        Connection connection = null;
//        
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            connection = DriverManager.getConnection(CONNECTION_URL, USERNAME , PASSWORD);
//        } catch (ClassNotFoundException e) {
//            System.out.println("Driver tidak ditemukan: " + e.getMessage());
//        } catch (SQLException e) {
//            System.out.println("Gagal konek DB: " + e.getMessage());
//        }
//        return connection;
//    }
//    public static void main(String[] args) {
//        try (Connection conn = getConnection()) {
//            
//            if (conn != null) {
//                System.out.println("Koneksi ke MySQL berhasil!");
//            }
//        } catch (SQLException e) {
//            System.out.println("Koneksi gagal!");
//            e.printStackTrace();
//        }
//    }
//}

package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class JDBC {
    
    private static final String DATABASE_NAME = "fintrack_db";
    private static final String USERNAME = "root";    
    private static final String PASSWORD = "root";    
    private static final String CONNECTION_URL = 
            "jdbc:mysql://localhost:8889/" + DATABASE_NAME + "?useSSL=false&serverTimezone=Asia/Jakarta";
    public static Connection getConnection() {
        Connection connection = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(CONNECTION_URL, USERNAME , PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Driver tidak ditemukan: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Gagal konek DB: " + e.getMessage());
        }
        return connection;
    }
    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            
            if (conn != null) {
                System.out.println("Koneksi ke MySQL berhasil!");
            }
        } catch (SQLException e) {
            System.out.println("Koneksi gagal!");
            e.printStackTrace();
        }
    }
}

