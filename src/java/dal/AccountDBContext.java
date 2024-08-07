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
                    + "      ,[img]\n"
                    + "     ,[salt]\n"
                    + "      ,[role]\n"
                    + "      ,[salt]\n"
                    + "      ,[status]\n"
                    + "      ,[lastLogin]\n"
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
                account.setSalt(rs.getString("salt"));
                account.setAddresses(getAddressByAid(account.getAid()));
                String img = rs.getString("img");
                if (img == null || img.trim().isEmpty()) {
                    img = "img/profile_picture/placeholder.png";
                }
                account.setImg(img);
                account.setRole(rs.getString("role"));
                account.setLastLogin(rs.getDate("lastLogin"));
                account.setStatus(rs.getString("status"));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkExisted(String username) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[img]\n"
                    + "     ,[salt]\n"
                    + "      ,[role]\n"
                    + "      ,[salt]\n"
                    + "  FROM Account\n"
                    + "  Where username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            return rs.next();

        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

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
                    + "      ,[img]\n"
                    + "     ,[salt]\n"
                    + "      ,[role]\n"
                    + "      ,[salt]\n"
                    + "      ,[status]\n"
                    + "      ,[lastLogin]\n"
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
                account.setSalt(rs.getString("salt"));
                account.setAddresses(getAddressByAid(account.getAid()));
                account.setLastLogin(rs.getDate("lastLogin"));
                account.setStatus(rs.getString("status"));
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

    public void setLastLogin(int aid) {
        String sql = "Update Account Set lastLogin = getDate() WHERE aid = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

    public Account get(int id) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[fullname]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[phonenumber]\n"
                    + "      ,[gender]\n"
                    + "      ,[birthdate]\n"
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
        String sql = "INSERT INTO [dbo].[Account] ([fullname], [username], [password], [email], [phonenumber], [gender], [birthdate], [img], [role], [salt], [status]) VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, username);
            stm.setString(3, password);
            stm.setString(4, email);
            stm.setString(5, null);
            stm.setBoolean(6, Boolean.valueOf(null));
            stm.setDate(7, null);
            stm.setString(8, "img/profile_picture/placeholder.png");
            stm.setString(9, "customer");
            stm.setString(10, salt);
            stm.setString(11, "Not Activated");
            stm.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int addNewStaff(Account account) {
        // Adjust the SQL query to include the salt column
        String sql = "INSERT INTO [dbo].[Account] ([fullname], [username], [password], [email], [phonenumber], [gender], [birthdate], [img], [role], [salt]) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getFullname());
            stm.setString(2, account.getUsername());
            stm.setString(3, account.getPassword());
            stm.setString(4, account.getEmail());
            stm.setString(5, account.getPhonenumber());
            stm.setBoolean(6, Boolean.valueOf(null));
            stm.setDate(7, null);
            stm.setString(9, "img/profile_picture/placeholder.png");
            stm.setString(10, "staff");
            // Set the salt parameter
            stm.setString(11, account.getSalt());
            return stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Fail");
        }
        return 0;
    }

    public int editStaff(Account account) {
        // Adjust the SQL query to include the salt column
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET  "
                + " [email] = ? , "
                + " [phonenumber] = ? "
                + " WHERE [aid] = ? ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getEmail());
            stm.setString(3, account.getPhonenumber());
            stm.setInt(4, account.getAid());
            return stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void changePassword(String aid, String newPass, String salt) {
        try {
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

    public void update(Account account) {
        try {
            String sql = "UPDATE Account SET fullname=?, username=?, password=?, email=?, phonenumber=?, gender=?, birthdate=?, img=?, role=? "
                    + "WHERE aid=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getFullname());
            stm.setString(2, account.getUsername());
            stm.setString(3, account.getPassword());
            stm.setString(4, account.getEmail());
            stm.setString(5, account.getPhonenumber());
            stm.setBoolean(6, account.getGender());
            stm.setDate(7, (Date) account.getBirthdate());
            stm.setString(9, account.getImg());
            stm.setString(10, account.getRole());
            stm.setInt(11, account.getAid());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<String> getAddressByAid(int aid) {
        ArrayList<String> addresses = new ArrayList<>();
        try {
            String sql = "SELECT address FROM Address WHERE aid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String address = rs.getString("address");
                System.out.println(address);
                addresses.add(address);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return addresses;
    }
}
