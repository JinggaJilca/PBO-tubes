package dao;

import model.Category;
import model.JDBC; // Memanggil koneksi database Anda
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // 1. Mengambil Semua Data Kategori (Read)
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories"; 
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("category_id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Menambah Kategori Baru (Create)
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (name, type) VALUES (?, ?)";
        boolean success = false;

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getType());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error addCategory: " + e.getMessage());
        }
        return success;
    }

    // 3. Mengubah Kategori (Update)
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET name = ?, type = ? WHERE category_id = ?";
        boolean success = false;

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getType());
            stmt.setInt(3, category.getCategoryID());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updateCategory: " + e.getMessage());
        }
        return success;
    }

    // 4. Menghapus Kategori (Delete)
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        boolean success = false;

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleteCategory: " + e.getMessage());
        }
        return success;
    }

// Method untuk mengambil satu kategori berdasarkan ID
    public Category getCategoryById(int categoryId) {
        Category category = null;
        
        // Pastikan nama kolom 'category_id' sesuai dengan tabel categories di database Anda.
        // Jika di database namanya 'id', silakan ganti menjadi 'id = ?'
        String sql = "SELECT * FROM categories WHERE category_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new Category();
                    // Sesuaikan setter ini dengan nama method di class Category.java Anda
                    category.setCategoryID(rs.getInt("category_id")); 
                    category.setName(rs.getString("name"));
                    category.setType(rs.getString("type"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }
       

}