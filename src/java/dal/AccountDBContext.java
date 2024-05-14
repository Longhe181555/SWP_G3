/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Account;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sonnt
 */
public class AccountDBContext extends DBContext<Account> {

    public Account getByUsernamePassword(String username, String password) {
        try {
            String sql = "SELECT username, password, id, role FROM Account\n"
                    + "WHERE username = ? AND password = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setUsername(username);
                account.setPassword(rs.getString("password"));
                account.setId(rs.getInt("id"));
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
        String sql = "SELECT username, password, id, role FROM Account";
        Statement stm = connection.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        while (rs.next()) {
            Account account = new Account();
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setId(rs.getInt("id"));
            account.setRole(rs.getString("role"));
            accounts.add(account);
        }
    } catch (SQLException ex) {
        Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return accounts;
}

    @Override
    public void insert(Account entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Account entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Account entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Account get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
