/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Account;
import entity.IEntity;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.EncryptionHelper;

public class AccountDBContext extends DBContext {

    
    
     
    
    

    public Account checkAccountExist(String username) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "     ,[salt]\n"
                    + "      ,[role]\n"
                    + "      ,[salt]\n"
                    + "  FROM Account\n"
                    + "  Where username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setFullname(rs.getString("fullname"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setPhonenumber(rs.getString("phonenumber"));
                account.setGender(rs.getBoolean("gender"));
                account.setBirthdate(rs.getDate("birthdate"));
                account.setAddress(rs.getString("address"));
                account.setSalt(rs.getString("salt"));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                account.setImg(img);
                account.setRole(rs.getString("role"));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public ArrayList<Account> list() {
        ArrayList<Account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setFullname(rs.getString("fullname"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setPhonenumber(rs.getString("phonenumber"));
                account.setGender(rs.getBoolean("gender"));
                account.setBirthdate(rs.getDate("birthdate"));
                account.setAddress(rs.getString("address"));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                account.setImg(img);
                account.setRole(rs.getString("role"));

                accounts.add(account);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

    

    

    

    
    public ArrayList<Account> getAllAccountByRole(String role) {
        ArrayList<Account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n"
                    + " WHERE [role] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, role);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setFullname(rs.getString("fullname"));
                account.setUsername(rs.getString("username"));
                account.setEmail(rs.getString("email"));
                account.setPhonenumber(rs.getString("phonenumber"));
                account.setGender(rs.getBoolean("gender"));
                account.setBirthdate(rs.getDate("birthdate"));
                account.setAddress(rs.getString("address"));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                account.setImg(img);
                account.setRole(rs.getString("role"));

                accounts.add(account);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }
    
    
    @Override
    public IEntity get(int id) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[salt]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n"
                    + "WHERE aid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setFullname(rs.getString("fullname"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setPhonenumber(rs.getString("phonenumber"));
                account.setGender(rs.getBoolean("gender"));
                account.setBirthdate(rs.getDate("birthdate"));
                account.setAddress(rs.getString("address"));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                account.setImg(img);
                account.setRole(rs.getString("role"));
                account.setSalt(rs.getString("salt"));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addNewAccount(String username, String email, String password, String salt) {
        // Adjust the SQL query to include the salt column
        String sql = "INSERT INTO [dbo].[Account] ([fullname], [username], [password], [email], [phonenumber], [gender], [birthdate], [address], [img], [role], [salt]) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, username);
            stm.setString(3, password);
            stm.setString(4, email);
            stm.setString(5, null);
            stm.setBoolean(6, Boolean.valueOf(null));
            stm.setDate(7, null);
            stm.setString(8, null);
            stm.setString(9, "img/profile_picture/placeholder.png");
            stm.setString(10, "customer");
            // Set the salt parameter
            stm.setString(11, salt);
            stm.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void changePassword(String aid, String newPass, String salt) {
    try {
        // Hash the new password with the provided salt
        // Prepare the SQL statement
        String sql = "UPDATE Account SET password = ?, salt = ? WHERE aid = ?";

        // Execute the SQL statement
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, newPass);
        stm.setString(2, salt);
        stm.setString(3, aid);
        stm.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    public String getSaltForUsername(String username) {
    String salt = null;
    try {
        String sql = "SELECT salt FROM Account WHERE username = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, username);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            salt = rs.getString("salt");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return salt;
}
    
    
    
    
    public String getSaltForUser(int userId) {
    String salt = null;
    try {
        String sql = "SELECT salt FROM Account WHERE aid = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, userId);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            salt = rs.getString("salt");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return salt;
}
    public String getSaltForUser(String userId) {
    String salt = null;
    try {
        String sql = "SELECT salt FROM Account WHERE aid = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, userId);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            salt = rs.getString("salt");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return salt;
}

    @Override
    public void insert(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(IEntity entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
