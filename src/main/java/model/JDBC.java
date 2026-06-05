package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {

    private static final String SERVER_NAME = "127.0.0.1";
    private static final String PORT = "3306";
    private static final String DATABASE_NAME = "fintrack_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    private static final String CONNECTION_URL =
            "jdbc:mysql://" + SERVER_NAME + ":" + PORT + "/" + DATABASE_NAME
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL tidak ditemukan. Pastikan mysql-connector-j.jar sudah masuk ke WEB-INF/lib atau Libraries project.", e);
        }

        return DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
    }

    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            System.out.println("Koneksi ke MySQL berhasil!");
        } catch (SQLException e) {
            System.out.println("Koneksi gagal!");
            e.printStackTrace();
        }
    }
}