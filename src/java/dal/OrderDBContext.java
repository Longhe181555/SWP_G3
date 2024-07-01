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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class OrderDBContext extends DBContext {

    public List<Order> getOrdersByDate(Date date) {
        List<Order> orders = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [order] WHERE [order_date] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, new java.sql.Date(date.getTime()));
            ResultSet rs = stm.executeQuery();
            Order order;
            while (rs.next()) {
                order = new Order();
                order.setTotalAmount(rs.getInt("total_amount"));
                order.setStatus(rs.getInt("status"));
                orders.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orders;
    }

    public HashMap<Integer, Integer> getTotalAmountByYear(int year) {
        HashMap<Integer, Integer> result = new HashMap();
        try {
            String sql = "SELECT DATEPART(month , [order_date]) as month , SUM(total_amount) as total_amount FROM [order]\n"
                    + "WHERE DATEPART(year , [order_date]) = ?  group by DATEPART(month , [order_date])";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, year);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int totalAmount = rs.getInt("total_amount");
                int month = rs.getInt("month");
                result.put(month, totalAmount);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

}
