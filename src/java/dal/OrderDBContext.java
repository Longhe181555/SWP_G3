/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Order;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chi
 */
public class OrderDBContext extends DBContext<Order> {

    @Override
    public ArrayList<Order> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Order entity) {
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
        try {
            String sql = "INSERT INTO [dbo].[Order]\n"
                    + "           ([aid]\n"
                    + "           ,[date]\n"
                    + "           ,[description]\n"
                    + "           ,[status]\n"
                    + "           ,[total])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,GETDATE()\n"
                    + "           ,null\n"
                    + "           ,0\n"
                    + "           ,?)";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, entity.getAccountId());
            stm.setDouble(2, entity.getTotal());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, "SQL Exception: " + ex.getMessage(), ex);
        }

    }

    public int getLastOrder() {
        int lastOrderId = -1;
        try {
            String sql = "SELECT TOP (1) [orid]\n"
                    + "  FROM [SWP_G3].[dbo].[Order] ORDER BY orid DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
            lastOrderId = rs.getInt(1); 
        }

        } catch (SQLException ex) {
            Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, "SQL Exception: " + ex.getMessage(), ex);
        }
         return lastOrderId;
    }

    @Override
    public void update(Order entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Order entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Order get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public static void main(String[] args) {
        OrderDBContext c = new OrderDBContext();
        System.out.println(c.getLastOrder());
    }

}
