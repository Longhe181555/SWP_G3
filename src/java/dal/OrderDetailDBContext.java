/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chi
 */
public class OrderDetailDBContext extends DBContext<OrderDetail> {

    @Override
    public ArrayList<OrderDetail> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(OrderDetail entity) {
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody

        try {
            String sql = "INSERT INTO [dbo].[OrderItem]\n"
                    + "           ([amount]\n"
                    + "           ,[pid]\n"
                    + "           ,[orid]\n"
                    + "           ,[size_id]\n"
                    + "           ,[color_id])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";

            String sql2 = "UPDATE [dbo].[ProductItem]\n"
                    + "   SET [stockcount] = [stockcount] - ?\n"
                    + " WHERE pid = ? AND sid = ? AND cid = ?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, entity.getQuantity());
            stm.setInt(2, entity.getProductId());
            stm.setInt(3, entity.getOrderId());
            stm.setInt(4, entity.getSizeId());
            stm.setInt(5, entity.getColorId());
            
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm2.setInt(1, entity.getQuantity());
            stm2.setInt(2, entity.getProductId());
            stm2.setInt(3, entity.getSizeId());
            stm2.setInt(4, entity.getColorId());

            stm.executeUpdate();
            stm2.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDBContext.class.getName()).log(Level.SEVERE, "SQL Exception: " + ex.getMessage(), ex);
        }
    }

    @Override
    public void update(OrderDetail entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(OrderDetail entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public OrderDetail get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
