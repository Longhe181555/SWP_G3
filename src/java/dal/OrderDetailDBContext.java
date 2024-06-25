/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.Order;
import entity.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author duong
 */
public class OrderDetailDBContext extends DBContext {
    
    @Override
    public ArrayList list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
    
    @Override
    public IEntity get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public OrderDetail getOrderDetail(int orid) {
       
        try {
            String sql = "SELECT * FROM vw_OrderDetail where orid=?";
            PreparedStatement stm = connection.prepareCall(sql);
            stm.setInt(1, orid);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrid(rs.getInt("orid"));
                orderDetail.setAid(rs.getInt("aid"));
                orderDetail.setDate(rs.getString("date"));
                orderDetail.setDescription(rs.getString("description"));
                orderDetail.setStatus(rs.getString("status"));
                orderDetail.setApprovalStatus("approval_status");
                orderDetail.setTotalAmount(rs.getDouble("total_amount"));
                orderDetail.setItems(rs.getString("items"));
                return orderDetail;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateOrderStatus(int orid, String approvalStatus) {
        
        try {
            String sql = "UPDATE dbo.[Order] SET approval_status = ? WHERE orid = ?";
            PreparedStatement stm = connection.prepareCall(sql);
            stm.setString(1, approvalStatus);
            stm.setInt(2, orid);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
