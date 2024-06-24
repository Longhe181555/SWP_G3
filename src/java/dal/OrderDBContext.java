/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.IEntity;
import entity.Order;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author duong
 */
public class OrderDBContext extends DBContext {

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
     public List<Order> getPendingOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            String sql = "SELECT orid, aid, date, description, status, pmid FROM [Order] WHERE status = 'Pending'";
            PreparedStatement stm = connection.prepareCall(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrid(rs.getInt("orid"));
                order.setAid(rs.getInt("aid"));
                order.setDate(rs.getDate("date"));
                order.setDescription(rs.getString("description"));
                order.setStatus(rs.getString("status"));
                order.setPmid(rs.getInt("pmid"));
                orders.add(order);
//                System.out.println("Order ID: " + order.getOrid());
//                System.out.println("AID: " + order.getAid());
//                System.out.println("Date: " + order.getDate());
//                System.out.println("Description: " + order.getDescription());
//                System.out.println("Status: " + order.getStatus());
//                System.out.println("PMID: " + order.getPmid());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Number of pending orders fetched: " + orders.size());
        return orders;
     }
}
