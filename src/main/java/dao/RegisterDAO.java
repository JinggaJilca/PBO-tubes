package dao;

import model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class RegisterDAO {
    private void printKoneksiGagal(){
        System.out.println("Koneksi Gagal");
    }   
    public boolean isUserAda(String username, String email){
        boolean ada = false;
        
        String query = "SELECT user_id FROM Users WHERE username = ? OR email = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement smt = conn.prepareStatement(query)){
                
                smt.setString(1, username);
                smt.setString(2, email);
                
                try(ResultSet rs = smt.executeQuery()){
                    if(rs.next()){
                        //Jika data ada, maka
                        ada = true;
                    }
                }
  
        } catch (SQLException e) {
            System.out.println("Terjadi error mengecek user");
        }catch(NullPointerException e){
            printKoneksiGagal();
        }
        return ada;
    }
    public boolean addUser(User user){
        boolean done = false;
        String query = "INSERT INTO Users (username, email, password) VALUES (?, ?, ?)";
        try (Connection conn = JDBC.getConnection();
                PreparedStatement smt = conn.prepareStatement(query)){

                smt.setString(1, user.getUsername());
                smt.setString(2, user.getEmail());
                smt.setString(3, user.getPassword());
                
                int rowInserted = smt.executeUpdate();
                if(rowInserted > 0){
                    done = true;
                }
                       
        }catch(SQLException e){
            System.out.println("[Error] saat menambahkan pengguna " + e.getMessage());
            e.printStackTrace();
                
        }catch(NullPointerException e){
            printKoneksiGagal();
        }
        return done;
    }
}
