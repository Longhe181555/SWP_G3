/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Cart;
import entity.Order;
import entity.OrderItem;
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
  AccountDBContext adb = new AccountDBContext();
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

    public ArrayList<Order> getByAid(int aid) {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "    o.orid,\n"
                    + "    o.totalPrice,\n"
                    + "    COUNT(DISTINCT oi.piid) AS productCount,\n"
                    + "    o.date,\n"
                    + "    o.status,\n"
                    + "    o.description,\n"
                    + "    o.address\n"
                    + "FROM \n"
                    + "    [Order] o\n"
                    + "JOIN \n"
                    + "    OrderItem oi ON o.orid = oi.orid\n"
                    + "	WHERE o.aid = ?\n"
                    + "GROUP BY \n"
                    + "    o.orid, o.totalPrice, o.date, o.status, o.address, o.description\n"
                    + "ORDER BY \n"
                    + "    o.orid ASC;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("orid"));
                o.setAddress(rs.getString("address"));
                o.setDate(rs.getDate("date"));
                o.setNote(rs.getString("description"));
                o.setStatus(rs.getInt("status"));
                o.setTotalAmount(rs.getInt("productCount"));
                o.setTotalPrice(rs.getInt("totalPrice"));
                orders.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orders;
    }

    public Order createOrder(int aid, String note, int totalPrice, String payment, String address, ArrayList<Cart> carts) {
        Order order = null;
        try {
            String insertOrderSQL = "INSERT INTO [Order] (aid, description, totalPrice, address, date, status, payment) VALUES (?, ?, ?, ?,GETDATE(), 0, ?)";
            PreparedStatement stm = connection.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stm.setInt(1, aid);
            stm.setString(2, note);
            stm.setInt(3, totalPrice);
            stm.setString(4, address);
            stm.setString(5, payment);
            stm.executeUpdate();

            ResultSet generatedKeys = stm.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                insertOrderItems(orderId, carts);
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        CartDBContext cdb = new CartDBContext();
        cdb.removeCartByAid(aid);
        return order;
    }

    private void insertOrderItem(int orderId, Cart cart) throws SQLException {
        String insertOrderItemSQL = "INSERT INTO OrderItem (amount, soldPrice, piid, orid, did) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stm = connection.prepareStatement(insertOrderItemSQL);
        stm.setInt(1, cart.getAmount());
        stm.setInt(2, cart.getProductItem().getDiscountedPrice());
        stm.setInt(3, cart.getProductItem().getPiid());
        stm.setInt(4, orderId);
        stm.setInt(5, cart.getProductItem().getDiscount().getDid());
        stm.executeUpdate();
    }

    private void insertOrderItemWithoutDiscount(int orderId, Cart cart) throws SQLException {
        String insertOrderItemSQL = "INSERT INTO OrderItem (amount, soldPrice, piid, orid) VALUES (?, ?, ?, ?)";
        PreparedStatement stm = connection.prepareStatement(insertOrderItemSQL);
        stm.setInt(1, cart.getAmount());
        stm.setInt(2, cart.getProductItem().getDiscountedPrice());
        stm.setInt(3, cart.getProductItem().getPiid());
        stm.setInt(4, orderId);
        stm.executeUpdate();
    }

    private void insertOrderItems(int orderId, ArrayList<Cart> carts) {
        try {
            for (Cart c : carts) {
                if (c.getProductItem().getDiscount().getDtype() != null) {
                    insertOrderItem(orderId, c);
                } else {
                    insertOrderItemWithoutDiscount(orderId, c);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public Order getByOrid(int orid) {
    Order order = null;
    try {
        String sql = "SELECT orid, aid, date, description, status, totalPrice, address, payment " +
                     "FROM [Order] " +
                     "WHERE orid = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, orid);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            order = new Order();
            order.setOrderId(rs.getInt("orid"));
            order.setDate(rs.getDate("date"));
            order.setAccount(adb.get(rs.getInt("aid")));
            order.setStatus(rs.getInt("status"));
            order.setNote(rs.getString("description"));
            order.setTotalPrice(rs.getInt("totalPrice"));
            order.setAddress(rs.getString("address"));
            order.setPayment(rs.getString("payment"));
        }
    } catch (SQLException ex) {
        Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return order;
}
}
