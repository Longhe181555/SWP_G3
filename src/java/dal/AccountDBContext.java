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

public class AccountDBContext extends DBContext {

    public Account getByUsernamePassword(String username, String password) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[loginname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n"
                    + "  Where username = ? and password = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setLoginname(rs.getString("loginname"));
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
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Account checkAccountExist(String username) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[loginname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n"
                    + "  Where username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setLoginname(rs.getString("loginname"));
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
                    + "      ,[loginname]\n"
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
                account.setLoginname(rs.getString("loginname"));
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

    public Boolean checkConnection() {
        try {
            String sql = "SELECT Connection \n"
                    + "  FROM ConnectionStatus\n";
            Statement stm = connection.createStatement();
            ResultSet rs = stm.executeQuery(sql);
            while (rs.next()) {
                Boolean status = rs.getBoolean("Connection");
                return status;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public void insert(IEntity entity) {
        Account account = (Account) entity;
        try {
            String sql = "INSERT INTO Account (loginname, username, password, email, phonenumber, gender, birthdate, address, img, role) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getLoginname());
            stm.setString(2, account.getUsername());
            stm.setString(3, account.getPassword());
            stm.setString(4, account.getEmail());
            stm.setString(5, account.getPhonenumber());
            stm.setBoolean(6, account.getGender());
            stm.setDate(7, account.getBirthdate());
            stm.setString(8, account.getAddress());
            stm.setString(9, account.getImg());
            stm.setString(10, account.getRole());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void update(IEntity entity) {
        Account account = (Account) entity;
        try {
            String sql = "UPDATE Account SET loginname=?, username=?, password=?, email=?, phonenumber=?, gender=?, birthdate=?, address=?, img=?, role=? "
                    + "WHERE aid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getLoginname());
            stm.setString(2, account.getUsername());
            stm.setString(3, account.getPassword());
            stm.setString(4, account.getEmail());
            stm.setString(5, account.getPhonenumber());
            stm.setBoolean(6, account.getGender());
            stm.setDate(7, account.getBirthdate());
            stm.setString(8, account.getAddress());
            stm.setString(9, account.getImg());
            stm.setString(10, account.getRole());
            stm.setInt(11, account.getAid());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void delete(IEntity entity) {
        Account account = (Account) entity;
        try {
            String sql = "DELETE FROM Account WHERE aid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, account.getAid());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public IEntity get(int id) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[loginname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[address]\n"
                    + "      ,[img]\n"
                    + "      ,[role]\n"
                    + "  FROM Account\n"
                    + "WHERE aid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAid(rs.getInt("aid"));
                account.setLoginname(rs.getString("loginname"));
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
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addNewdAccount(String username, String email, String password) {
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([loginname]\n"
                + "           ,[username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[phonenumber]\n"
                + "           ,[gender]\n"
                + "           ,[birthdate]\n"
                + "           ,[address]\n"
                + "           ,[img]\n"
                + "           ,[role])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?,?)";
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
            stm.setString(10,"customer");
            stm.execute();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
     public void changePassword(String uid, String pass) {
        String sql = " update [Account] set [password]=? where [aid] = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pass);
            stm.setString(2, uid);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
}
