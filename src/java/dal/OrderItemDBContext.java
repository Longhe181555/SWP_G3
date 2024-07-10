/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderItemDBContext extends DBContext {
ProductItemDBContext pidb = new ProductItemDBContext();
    public ArrayList<OrderItem> getByOrid(int orid) {
        ArrayList<OrderItem> orderItems = new ArrayList<>();
        try {
            String sql = "SELECT oi.oiid, oi.amount, oi.soldPrice,oi.piid, oi.piid, oi.orid, oi.product_status, d.did, dt.type, d.[value], d.[from], d.[to]\n"
                    + "FROM OrderItem oi\n"
                    + "LEFT JOIN Discount d ON oi.did = d.did\n"
                    + "LEFT JOIN DiscountType dt on d.dtid = dt.dtid \n"
                    + "WHERE oi.orid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, orid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                OrderItem oi = new OrderItem();
                oi.setOiid(rs.getInt("oiid"));
                oi.setAmount(rs.getInt("amount"));
                oi.setSoldPrice(rs.getInt("soldPrice"));
                oi.setPiid(rs.getInt("piid"));
                oi.setOrderId(rs.getInt("orid"));
                oi.setProduct_status(rs.getString("product_status"));
                oi.setProductItem(pidb.getByPiid(rs.getInt("piid")));
               if (rs.getString("type") != null && rs.getInt("value") != 0) {
                    Discount discount = new Discount();
                    discount.setDid(rs.getInt("did"));
                    discount.setDtype(rs.getString("type"));
                    discount.setValue(rs.getInt("value"));
                    discount.setFrom(rs.getDate("from"));
                    discount.setTo(rs.getDate("to"));
                    oi.setDiscount(discount);
                }

                orderItems.add(oi);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderItems;
    }
}
